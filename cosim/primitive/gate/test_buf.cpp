#include "gate-utils.hpp"

unsigned long test_buf(unsigned long input, unsigned way, unsigned wire)
{
  return (input & get_n_bits_bitmasks[wire]);
}
