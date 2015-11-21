#include <bits/stdc++.h>
#include <cuda.h>
//Height and Weight (Tamaño de la Matriz)
#define N 10

using namespace std;

void fill(int *Matrix){
    for(int i=0; i<N; i++){
        for(int j=0; j<N; j++){
            Matrix[(i*N)+j] = j;
        }
    }
}

void display(int *Matrix){
    for(int i=0; i<N; i++){
        for(int j=0; j<N; j++){
            cout<<Matrix[i*N+j]<<" ";
        }
        cout<<endl;
    }
    cout<<endl;
}

//Multiplicación CPU
void mult(int *A, int *B,int *C){
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

//Multiplicación GPU
__global__ void multMat(int *a, int *b, int *c){
	int k, value = 0;
	int col = threadIdx.x + blockDim.x * blockIdx.x;
	int row = threadIdx.y + blockDim.y * blockIdx.y;

	if(col < N && row < N) {
		for(k = 0; k < N; k++) value += a[row * N +k] * b[k * N + col];
		c[row * N +col]	 = value;	
	}
}

int main(){
	int *A = (int*)malloc(N*N*sizeof(int));
	int *B = (int*)malloc(N*N*sizeof(int));
	int *C = (int*)malloc(N*N*sizeof(int));
	int *D = (int*)malloc(N*N*sizeof(int));

	//Creacion de las matrices
	fill(A);
	fill(B);

	mult(A, B, C); //CPU

	//Muestra el contenido de las matrices
	display(A);
	display(B);
	display(C);

	return 0;
}