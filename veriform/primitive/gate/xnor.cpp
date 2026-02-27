#include "gate-utils.hpp"

unsigned long test_xnor(unsigned long input, unsigned way, unsigned wire)
{
  unsigned long mask = get_n_bits_bitmasks[wire];
  return ((test_xor(input, way, wire) ^ mask) & mask);
}
