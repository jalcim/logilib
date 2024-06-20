void veriform_add_sub(unsigned int *results, unsigned int max_int, unsigned int sub,
                      unsigned int operandA, unsigned int operandB,
                      unsigned int cin)
{
  operandA = operandA & max_int;
  operandB = operandB & max_int;
  cin = cin & 1;

  results[0] = sub ?
    (operandA + operandB + cin) & max_int
    :(operandA - operandB) & max_int;

  results[1] = sub ? 0
    : max_int - operandA < operandB
    || (max_int - operandA == operandB && cin == 1);
}

/*
void equational(unsigned int *results, unsigned int max_int, unsigned int sub,
		unsigned int operandA, unsigned int operandB,
		unsigned int cin)
{
  operandA = operandA & max_int;
  operandB = operandB & max_int;
  cin = (cin | sub) & 1;
  
  operandB = (sub ? ~operandB : operandB) & max_int;
  results[0] = (operandA + operandB + cin) & max_int;
  results[1] = sub ? 0 :
    max_int - operandA < operandB
    || (max_int - operandA == operandB && cin);
}
*/

/*
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int main()
{
  unsigned int *results = malloc(sizeof(unsigned int) *2);
  unsigned int max_int = INT_MAX;//2**WIRE-1
  unsigned int sub = 0;

  unsigned int operandA = INT_MAX;
  unsigned int operandB = INT_MAX;
  unsigned int cin = 0;

  veriform_add_sub(results, max_int, sub, operandA, operandB, cin);
  printf("results = %u, cout = %u\n"
   "max_int = %u, sub = %u\n"
   "operandA = %u, operandB = %u\n"
   "cin = %u\n\n",
   results[0], results[1], max_int, sub, operandA, operandB, cin);
  free(results);
}
*/
