#include <iostream>
#include <cmath>
#include "addx_macros.h"

void addx_test_check(unsigned int *results, unsigned int max_int, unsigned int operandA, unsigned int operandB, unsigned int cin, unsigned int nb_wires)
{
  results[0] = (operandA + operandB + cin) & max_int;
  results[1] = max_int - operandA < operandB || (max_int - operandA == operandB && cin == 1);
}
