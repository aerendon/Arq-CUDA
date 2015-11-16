#include <bits/stdc++.h>
#include <cuda.h>
//Height and Weight (Tamaño de la Matriz)
#define HEIGHT 10
#define WEIGHT 10

using namespace std;

void fill(int *Matrix){
    for(int i=0; i<HEIGHT; i++){
        for(int j=0; j<WEIGHT; j++){
            Matrix[(i*WEIGHT)+j] = 1;
        }
    }
}

void display(int *Matrix){
    for(int i=0; i<HEIGHT; i++){
        for(int j=0; j<WEIGHT; j++){
            cout<<Matrix[i*WEIGHT+j]<<" ";
        }
        cout<<endl;
    }
}

//Multiplicación CPU
void mult(int *A, int *B,int *C){
	int aux = 0;
	for(int i=0; i<HEIGHT; i++){
		for(int j=0; j<WEIGHT; j++){
			aux = 0;
			for(int k=0; k<HEIGHT; k++)
			    aux += A[i*WEIGHT+k]* B[k*WEIGHT+j];
			C[i*WEIGHT+j] = aux;
		}
	}
}

int main(){
	int *A = (int*)malloc(HEIGHT*WEIGHT*sizeof(int));
	int *B = (int*)malloc(HEIGHT*WEIGHT*sizeof(int));
	int *C = (int*)malloc(HEIGHT*WEIGHT*sizeof(int));
	int *D = (int*)malloc(HEIGHT*WEIGHT*sizeof(int));

	fill(A);
	fill(B);

	display(A);
	display(B);
	display(C);

	return 0;
}