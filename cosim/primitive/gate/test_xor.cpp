#include "gate-utils.hpp"

unsigned long test_xor(unsigned long input, unsigned way, unsigned wire)
{
  unsigned long result = 0;
  unsigned long mask = get_n_bits_bitmasks[wire];

  for (unsigned cpt=0; cpt < way; cpt++)
    result ^= (input >> (wire*cpt)) & mask;
  return (result & mask);
}
