#include <bits/stdc++.h>
#include <cuda.h>
//Height and Weight (Tamaño de la Matriz)
#define HEIGHT 1000
#define WEIGHT 1000

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
            cout<<v[i*WEIGHT+j]<<" ";
        }
        cout<<endl;
    }
}

//Multiplicación CPU
void mult(int *A, int *B,int *C){
	int aux = 0;
	for(int i=0; i<H; i++){
		for(int j=0; j<W; j++){
			aux = 0;
			for(int k=0; k<H; k++)
			    aux += A[i*W+k]* B[k*W+j];
			C[i*W+j] = aux;
		}
	}
}

int main(){

	return 0;
}