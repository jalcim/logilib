#include <stdio.h>
#include <math.h>
#define WAY 4
#define SIZE 16
#define WIRE 8

int recurse (int counter, int size_counter, int indice);
int main()
{
  printf ("line : %d\n", 0);
  recurse (0, 0, 0);
  printf("\n");
}

int recurse (int counter, int size_counter, int indice)
{
  int mask = 1 << indice;
  int offset = (indice * WIRE) + counter;

  if (size_counter < SIZE)
    {
      if (size_counter & mask)
	{
	  printf("\tout[%d] = in[%d]\n", offset, size_counter);
	  recurse(counter+1, size_counter+1, indice);
	}
      else
	recurse(counter, size_counter+1, indice);
    }
  if (indice < (WAY-1) && size_counter == 0)
    {
      printf ("line : %d\n", indice+1);
      recurse(0, 0, indice+1);
    }
}
