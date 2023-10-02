#include "gate_macros.h"
#include <iostream>
#include <cmath>

int test_lsb_buf(int input, int way_number)
{
  return input & 1;
}

int test_lsb_not(int input, int way_number)
{
  return ~input & 1;
}

int test_lsb_and(int input, int way_number)
{

  if (way_number < 3)
  {
    return GET_BIT(input, 1) & GET_BIT(input, 0);
  }
  return GET_BIT(input, (way_number - 1)) & test_lsb_and(input & get_n_bits_bitmasks[way_number - 1], way_number - 1);
}

int test_lsb_nand(int input, int way_number)
{
  return ~(test_lsb_and(input, way_number));
}

int test_lsb_or(int input, int way_number)
{
  if (way_number < 3)
    return GET_BIT(input, 1) | GET_BIT(input, 0);
  return GET_BIT(input, (way_number - 1)) | test_lsb_and(input & get_n_bits_bitmasks[way_number - 1], way_number - 1);
}

int test_lsb_nor(int input, int way_number)
{
  return ~(test_lsb_or(input, way_number));
}

int test_lsb_xor(int input, int way_number)
{
  if (way_number < 3)
    return GET_BIT(input, 1) ^ GET_BIT(input, 0);
  return GET_BIT(input, (way_number - 1)) ^ test_lsb_xor(input & get_n_bits_bitmasks[way_number - 1], way_number - 1);
}

int test_lsb_xnor(int input, int way_number)
{
  return ~(test_lsb_xor(input, way_number));
}

int test_msb_buf(int input, int way_number)
{
  return input & 1;
}

int test_msb_not(int input, int way_number)
{
  return ~input & 1;
}

int test_msb_and(int input, int way_number)
{
  if (way_number < 3)
    return GET_BIT(input, 1) & GET_BIT(input, 0);
  return (input & 1) & test_msb_and(input >> 1, way_number - 1);
}

int test_msb_nand(int input, int way_number)
{
  return ~(test_msb_and(input, way_number));
}

int test_msb_or(int input, int way_number)
{
  if (way_number < 3)
    return GET_BIT(input, 1) | GET_BIT(input, 0);
  return (input & 1) | test_msb_or(input >> 1, way_number - 1);
}

int test_msb_nor(int input, int way_number)
{
  return ~(test_msb_or(input, way_number));
}

int test_msb_xor(int input, int way_number)
{
  if (way_number < 3)
    return GET_BIT(input, 1) ^ GET_BIT(input, 0);
  return (input & 1) ^ test_msb_xor(input >> 1, way_number - 1);
}

int test_msb_xnor(int input, int way_number)
{
  return ~(test_msb_xor(input, way_number));
}
