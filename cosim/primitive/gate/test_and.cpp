#include "gate-utils.hpp"

unsigned long test_and(unsigned long input, unsigned way, unsigned wire)
{
  unsigned long result = 0xFFFFFFFFFFFFFFFF;
  unsigned long mask = get_n_bits_bitmasks[wire];

  for (unsigned cpt=0; cpt < way; cpt++)
    result &= (input >> (wire*cpt)) & mask;
  return (result & mask);
}
