#include "Dlatch-utils.hpp"

t_latch *test_Dlatch(unsigned int D, unsigned int clk)
{
  static t_latch *latch = new t_latch{0};

  latch->QN = ~(latch->Q = clk ? D : latch->Q);

  return (latch);
}
