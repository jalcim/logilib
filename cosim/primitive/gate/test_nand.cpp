#include "gate-utils.hpp"

unsigned long test_nand(unsigned long input, unsigned way, unsigned wire)
{
  unsigned long mask = get_n_bits_bitmasks[wire];
  return ((test_and(input, way, wire) ^ mask) & mask);
}
