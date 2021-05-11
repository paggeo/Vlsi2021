#include <iostream>

using namespace std;

int main()
{
  int N;
  cin >> N;

  int A[N][N];
  int G[N][N], B[N][N], R[N][N];
  int i = 0, UL, UR, UC, LR, LL, LC, CR, CC, CL;
  int j = 0;
  for (int i = 0; i < N; i++)
  {
    for (int j = 0; j < N; j++)
    {
      cin >> A[i][j];
    }
  }

  for (i = 0; i < N; i++)
  {
    for (j = 0; j < N; j++)
    {

      if (i == 0 or j == 0)
      {
        UL = 0;
      }
      else
      {
        UL = A[i - 1][j - 1];
      }

      if (i == 0)
      {
        UC = 0;
      }
      else
      {
        UC = A[i - 1][j];
      }

      if (i == 0 or j == N - 1)
      {
        UR = 0;
      }
      else
      {
        UR = A[i - 1][j + 1];
      }

      if (j == 0)
      {
        CL = 0;
      }
      else
      {
        CL = A[i][j - 1];
      }

      CC = A[i][j];

      if (j == N - 1)
      {
        CR = 0;
      }
      else
      {
        CR = A[i][j + 1];
      }

      if (i == N - 1 or j == 0)
      {
        LL = 0;
      }
      else
      {
        LL = A[i + 1][j - 1];
      }

      if (i == N - 1)
      {
        LC = 0;
      }
      else
      {
        LC = A[i + 1][j];
      }

      if (i == N - 1 or j == N - 1)
      {
        LR = 0;
      }
      else
      {
        LR = A[i + 1][j + 1];
      }

      if (i % 2 == 0)
      {
        if (j % 2 == 0)
        { // periptosi ii
          G[i][j] = (CC);
          B[i][j] = (CL + CR) / 2;
          R[i][j] = (UC + LC) / 2;
        }
        else
        { // periptosi iv
          B[i][j] = (CC);
          R[i][j] = (UL + UR + LL + LR) / 4;
          G[i][j] = (UC + LC + CL + CR) / 4;
        }
      }
      else
      {
        if (j % 2 == 0)
        { // periptosi iii
          R[i][j] = (CC);
          B[i][j] = (UL + UR + LL + LR) / 4;
          G[i][j] = (UC + LC + CL + CR) / 4;
        }
        else
        { // periptosi i
          G[i][j] = (CC);
          B[i][j] = (UC + LC) / 2;
          R[i][j] = (CL + CR) / 2;
        }
      }
    }
  }

  for (i = 0; i < N; i++)
  {
    for (j = 0; j < N; j++)
    {
      cout << R[i][j] << " " << G[i][j] << " " << B[i][j] << " " << endl;
    }
  }

  return 0;
}
