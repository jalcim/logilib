#include "Dlatch-utils.hpp"

t_latch *test_Dlatch(unsigned int D, unsigned int clk)
{
  static t_latch *latch = new t_latch{0};

  latch->QN = ~(latch->Q = clk ? D : latch->Q);

  return (latch);
}

t_latch *test_Dlatch_rst(unsigned int D, unsigned int clk, unsigned int rst)
{
  static t_latch *latch = new t_latch{0};

  unsigned int data;

  data = clk ? D : latch->Q;
  latch->Q = rst ? 0 : data;
  latch->QN = ~latch->Q;

  return (latch);
}

t_latch *test_Dlatch_pre(unsigned int D, unsigned int clk, unsigned int pre)
{
  static t_latch *latch = new t_latch{0};

  unsigned int data;

  data = clk ? D : latch->Q;
  latch->Q = pre ? 1 : data;
  latch->QN = ~latch->Q;

  return (latch);
}

t_latch *test_Dlatch_rst_pre(unsigned int D, unsigned int clk, unsigned int rst, unsigned int pre)
{
  static t_latch *latch = new t_latch{0};

  unsigned int data;

  data = clk ? D : latch->Q;
  latch->Q = rst ? 0 : pre ? 1 : data;
  latch->QN = ~latch->Q;

  return (latch);
}
