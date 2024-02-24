#include <iostream>
#include <cmath>
#include "addx_macros.h"
extern "C"
{
#include "verif_arithm.h"
}

void addx_test_check(unsigned int *results, unsigned int max_int, unsigned int operandA, unsigned int operandB, unsigned int cin, unsigned int nb_wires)
{
  return veriform_add_sub(results, max_int, 0,
                          operandA, operandB,
                          cin);
}
