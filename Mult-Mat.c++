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

int main(){

	return 0;
}