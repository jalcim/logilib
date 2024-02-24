#include <iostream>
#include <cmath>
#include "add_sub_macros.h"
#include <boost/log/trivial.hpp>
extern "C"
{
#include "verif_arithm.h"
}

void add_sub_test_check(unsigned int *results, unsigned int max_int, int operandA, int operandB, unsigned int cin, unsigned int sub, unsigned int nb_wires)
{
  return veriform_add_sub(results, max_int, sub,
                          operandA, operandB,
                          cin);
}
