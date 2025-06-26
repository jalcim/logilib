typedef struct s_latch t_latch;
struct s_latch
{
  unsigned int Q, QN;
};

t_latch *test_Dlatch(unsigned int D, unsigned int clk);
