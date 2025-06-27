#include "gate-utils.hpp"

unsigned long test_nor(unsigned long input, unsigned way, unsigned wire)
{
  unsigned long mask = get_n_bits_bitmasks[wire];
  return ((test_or(input, way, wire) ^ mask) & mask);
}
