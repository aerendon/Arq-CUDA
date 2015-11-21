#include <bits/stdc++.h>
#include <cuda.h>
#define N 7

using namespace std;

void multMatCPU(int *A, int *B,int *C){
	int aux = 0;
	for(int i=0; i<N; i++){
	    for(int j=0; j<N; j++){
		    aux = 0;
		    for(int k=0; k<N; k++)
		        aux += A[i*N+k]* B[k*N+j];
		    C[i*N+j] = aux;
	    }
	}
}

__global__ void multMatGPU(int *d_A, int *d_B,int *d_C){
	int i = blockIdx.y*blockDim.y+threadIdx.y;
	int j = blockIdx.x*blockDim.x+threadIdx.x;
	if(i < N && j < N){
	    int Pvalue = 0;
	    for(int k=0; k<N; k++){
	       	Pvalue += d_A[i*N+k] * d_B[k*N+j];
	    }
	    d_C[i*N+j] = Pvalue;
	}
}

/**
 * [fill: Llena un array bidimensional con el número 5]
 * @param Matrix [Array[][]]
 */
void fill(int* Matrix){
	for(int i=0; i<N; i++){
	    for(int j=0; j<N; j++){
	      	Matrix[i*N+j] = 5;
	    }
	}
}

/**
 * [display: Muestra un array bidimensional]
 * @param Matrix [Array[][]]
 */
void display(int *Matrix){
	for(int i=0; i<N; i++){
	    for(int j=0; j<N; j++){
	      	cout<<Matrix[i*N+j]<<" ";
	    }
	    cout<<endl;
	}
}


int main(){ 
	int *x = (int*)malloc(N*N*sizeof(int));
	int *y = (int*)malloc(N*N*sizeof(int));
	int *z = (int*)malloc(N*N*sizeof(int));
	//Reloj
	clock_t start, end;
	double cpu_time, gpu_time;

	//Matrices Iniciales
	fill(x);
	fill(y);

	//-------------CPU------------------------
	start = clock();
	multMatCPU(x,y,z);
	end = clock();

	//Mostrar Matrices
	//display(x); display(y); display(z);

	cpu_time = ((double) (end - start)) / CLOCKS_PER_SEC;
	printf("CPU = %lf s\n",cpu_time);

	//-------------GPU------------------------
	int *d_x,*d_y,*d_z;
	float blockSize = 32;
	dim3 dimBlock(blockSize,blockSize);
	dim3 dimGrid(ceil(N/float(blockSize)),ceil(N/float(blockSize)),1);

	cudaMalloc((void**)&d_x,sizeof(int)*N*N);
	cudaMalloc((void**)&d_y,sizeof(int)*N*N);
	cudaMalloc((void**)&d_z,sizeof(int)*N*N);

	start = clock();

	cudaMemcpy(d_x, x, sizeof(int)*N*N,cudaMemcpyHostToDevice);
	cudaMemcpy(d_y, y, sizeof(int)*N*N,cudaMemcpyHostToDevice);


	multMatGPU<<<dimGrid,dimBlock>>>(d_x, d_y, d_z);
	cudaMemcpy(z,d_z,sizeof(int)*N*N,cudaMemcpyDeviceToHost);
	end = clock();
	gpu_time = ((double) (end - start)) / CLOCKS_PER_SEC;
	printf("GPU = %lf s\n",gpu_time);

	//display(z);
	
	//Liberar Memoria
	free(x);
	free(y);
	free(z);

	cudaFree(d_x);
	cudaFree(d_y);
	cudaFree(d_z);

	return 0;  
}