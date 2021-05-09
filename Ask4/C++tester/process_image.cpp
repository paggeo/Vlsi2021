#include <iostream>
#include <stdlib.h> 
#include <ctime>
#include <vector>
#include <fstream>

using namespace std;

void print_vector(vector<vector<int>> &A,int N) {
  for(int i=0;i<N;i++){
      for(int j=0;j<N;j++){
          cout<<A[i][j]<<" ";          
      }
      cout<<endl;
  }
}

int main(){

    int N=4; 
    //vector<vector<int>> Vec(N,vector<int> (N));
    vector<vector<int>> Vec{
        {4,4,4,4},
        {4,4,4,4},
        {4,4,4,4},
        {4,4,4,4}
    };
    vector<vector<int>> Green(N,vector<int> (N));
    vector<vector<int>> Blue(N,vector<int> (N));
    vector<vector<int>> Red(N,vector<int> (N));

    for(int i=0;i<N;i++){
        for (int j=0;j<N;j++){
            if(i%2==0&&j%2==0) { // this is GB line
                
                Green[i][j]=Vec[i][j];

                if((j-1)<0) Blue[i][j]=Vec[i][j+1]/2;
                else if ((j+1)>=N) Vec[i][j-1]/2;
                else Blue[i][j]=(Vec[i][j-1]+Vec[i][j+1])/2;

                if((i-1)<0) Red[i][j]=Vec[i+1][j]/2;
                else if ((i+1)>=N) Red[i][j]=Vec[i-1][j]/2;
                else Red[i][j]=(Vec[i-1][j]+Vec[i+1][j])/2;
            }
            if(i%2==0&&j%2!=0) { // this is a blue pixel
                
                Blue[i][j]=Vec[i][j];

                if(((i-1)<0)&&(j-1)<0)          Green[i][j]=        (Vec[i+1][j]+Vec[i][j+1])/4;
                else if(((i-1)<0)&&(j+1)>=N)    Green[i][j]=        (Vec[i+1][j]+Vec[i][j-1])/4;
                else if(((i+1)>=N)&&(j-1)<0)    Green[i][j]=        (Vec[i-1][j]+Vec[i][j+1])/4;
                else if(((i+1)>=N)&&(j+1)>=N)   Green[i][j]=        (Vec[i-1][j]+Vec[i][j-1])/4;
                else if ((i-1)<0)               Green[i][j]=        (Vec[i+1][j]+Vec[i][j-1]+Vec[i][j+1])/4;
                else if ((i+1)>=N)              Green[i][j]=        (Vec[i-1][j]+Vec[i][j-1]+Vec[i][j+1])/4;
                else if ((j-1)<0)               Green[i][j]=        (Vec[i-1][j]+Vec[i+1][j]+Vec[i][j+1])/4;
                else if ((j+1)>=0)              Green[i][j]=        (Vec[i-1][j]+Vec[i+1][j]+Vec[i][j-1])/4;
                else                            Green[i][j]=        (Vec[i-1][j]+Vec[i+1][j]+Vec[i][j-1]+Vec[i][j+1])/4;


                if(((i-1)<0)&&(j-1)<0)          Red[i][j]=          Vec[i+1][j+1]/4;
                else if(((i-1)<0)&&(j+1)>=N)    Red[i][j]=          Vec[i+1][j-1]/4;
                else if(((i+1)>=N)&&(j-1)<0)    Red[i][j]=          Vec[i-1][j+1]/4;
                else if(((i+1)>=N)&&(j+1)>=N)   Red[i][j]=          Vec[i-1][j-1]/4;
                else if ((i-1)<0)               Red[i][j]=          (Vec[i+1][j-1]+Vec[i+1][j+1])/4;
                else if ((i+1)>=N)              Red[i][j]=          (Vec[i-1][j-1]+Vec[i-1][j+1])/4;
                else if ((j-1)<0)               Red[i][j]=          (Vec[i-1][j+1]+Vec[i+1][j+1])/4;
                else if ((j+1)>=0)              Red[i][j]=          (Vec[i-1][j-1]+Vec[i+1][j-1])/4;
                else                            Red[i][j]=          (Vec[i-1][j-1]+Vec[i-1][j+1]+Vec[i+1][j-1]+Vec[i+1][j+1])/4;
                
            }
            if(i%2!=0&&j%2==0){ // this is red pixel
                Red[i][j]=Vec[i][j];

                if(((i-1)<0)&&(j-1)<0)          Green[i][j]=        (Vec[i+1][j]+Vec[i][j+1])/4;
                else if(((i-1)<0)&&(j+1)>=N)    Green[i][j]=        (Vec[i+1][j]+Vec[i][j-1])/4;
                else if(((i+1)>=N)&&(j-1)<0)    Green[i][j]=        (Vec[i-1][j]+Vec[i][j+1])/4;
                else if(((i+1)>=N)&&(j+1)>=N)   Green[i][j]=        (Vec[i-1][j]+Vec[i][j-1])/4;
                else if ((i-1)<0)               Green[i][j]=        (Vec[i+1][j]+Vec[i][j-1]+Vec[i][j+1])/4;
                else if ((i+1)>=N)              Green[i][j]=        (Vec[i-1][j]+Vec[i][j-1]+Vec[i][j+1])/4;
                else if ((j-1)<0)               Green[i][j]=        (Vec[i-1][j]+Vec[i+1][j]+Vec[i][j+1])/4;
                else if ((j+1)>=0)              Green[i][j]=        (Vec[i-1][j]+Vec[i+1][j]+Vec[i][j-1])/4;
                else                            Green[i][j]=        (Vec[i-1][j]+Vec[i+1][j]+Vec[i][j-1]+Vec[i][j+1])/4;

                if(((i-1)<0)&&(j-1)<0)          Blue[i][j]=         Vec[i+1][j+1]/4;
                else if(((i-1)<0)&&(j+1)>=N)    Blue[i][j]=         Vec[i+1][j-1]/4;
                else if(((i+1)>=N)&&(j-1)<0)    Blue[i][j]=         Vec[i-1][j+1]/4;
                else if(((i+1)>=N)&&(j+1)>=N)   Blue[i][j]=         Vec[i-1][j-1]/4;
                else if ((i-1)<0)               Blue[i][j]=         (Vec[i+1][j-1]+Vec[i+1][j+1])/4;
                else if ((i+1)>=N)              Blue[i][j]=         (Vec[i-1][j-1]+Vec[i-1][j+1])/4;
                else if ((j-1)<0)               Blue[i][j]=         (Vec[i-1][j+1]+Vec[i+1][j+1])/4;
                else if ((j+1)>=0)              Blue[i][j]=         (Vec[i-1][j-1]+Vec[i+1][j-1])/4;
                else                            Blue[i][j]=         (Vec[i-1][j-1]+Vec[i-1][j+1]+Vec[i+1][j-1]+Vec[i+1][j+1])/4;
                
            }
            if(i%2!=0&&j%2!=0) { // this is RG line
                
                Green[i][j]=Vec[i][j];

                if((j-1)<0) Red[i][j]=Vec[i][j+1]/2;
                else if ((j+1)>=N) Red[i][j]=Vec[i][j-1]/2;
                else Red[i][j]=(Vec[i][j-1]+Vec[i][j+1])/2;

                if((i-1)<0) Blue[i][j]=Vec[i+1][j]/2;
                else if ((i+1)>=N) Blue[i][j]=Vec[i-1][j]/2;
                else Blue[i][j]=(Vec[i-1][j]+Vec[i+1][j])/2;
                
                
            }
        }
        
    }
    cout<<"This is Blue:\n";
    print_vector(Blue,N);
    cout<<"\nThis is Green:\n";
    print_vector(Green,N);
    cout<<"\nThis is Red:\n";
    print_vector(Red,N);
}