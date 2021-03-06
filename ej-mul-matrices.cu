//http://cocinando-tarjetas-graficas.blogspot.com.co/2013/09/multiplicar-matrices-en-cuda.html
#include <stdio.h>
#define N 16

void matrixMultCPU(int a[N][N], int b[N][N], int c[N][N]) {
int n,m;
 for (int i = 0; i < N; i++) {
  for (int j = 0; j < N; j++) {
   int sum = 0;
   for (int k = 0; k < N; k++) {
    m = a[i][k];
    n = b[k][j];
    sum += m * n;
   }
   c[i][j] = sum;
  }
 }
}

__global__ void matrixMultGPU(int *a, int *b, int *c) {
 int k, sum = 0;
 int col = threadIdx.x + blockDim.x * blockIdx.x;
 int fil = threadIdx.y + blockDim.y * blockIdx.y;

 if (col < N && fil < N) {
  for (k = 0; k < N; k++) {
   sum += a[fil * N + k] * b[k * N + col];
  }
  c[fil * N + col] = sum;
 }
}

int main() {
 int a[N][N], b[N][N], c[N][N];
 int *dev_a, *dev_b, *dev_c;
 int cont,i,j;

 /* inicializando variables con datos foo*/
 for (i = 0; i < N; i++) {
  cont = 0;
  for (j = 0; j < N; j++) {
   a[i][j] = cont;
   b[i][j] = cont;
   cont++;
  }
 }

 int size = N * N * sizeof(int);

 cudaMalloc((void **) &dev_a, size);
 cudaMalloc((void **) &dev_b, size);
 cudaMalloc((void **) &dev_c, size);

 cudaMemcpy(dev_a, a, size, cudaMemcpyHostToDevice);
 cudaMemcpy(dev_b, b, size, cudaMemcpyHostToDevice);

 dim3 dimGrid(1, 1);
 dim3 dimBlock(N, N);

 matrixMultGPU<<<dimGrid, dimBlock>>>(dev_a, dev_b, dev_c);

 cudaMemcpy(c, dev_c, size, cudaMemcpyDeviceToHost);

 cudaFree(dev_a);
 cudaFree(dev_b);
 cudaFree(dev_c);

 // imprimiendo
 for (int y = 0; y < N; y++) {
  for (int x = 0; x < N; x++) {
   printf("[%d][%d]=%d ", y, x, c[y][x]);
  }
  printf("\n");
 }

 return 0;

}