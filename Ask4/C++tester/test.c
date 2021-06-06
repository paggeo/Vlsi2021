#include <stdio.h>
    
    int A[1024][1024];
    int R[1024][1024];
    int G[1024][1024];
    int B[1024][1024];

int main(){
    


    int i,j;

    for (i=0;i<1024;i++){
        for (j=0;j<1024;j++){
            A[i][j]=0;
            R[i][j]=0;
            G[i][j]=0;
            B[i][j]=0;

            printf("%d,%d,%d,%d",A[i][j],R[i][j],G[i][j],B[i][j]);
        }
    }

    return 0;
}
