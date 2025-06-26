typedef struct s_latch t_latch;
struct s_latch
{
  unsigned int Q, QN;
};

t_latch *test_Dlatch(unsigned int D, unsigned int clk);
t_latch *test_Dlatch_rst(unsigned int D, unsigned int clk, unsigned int rst);
t_latch *test_Dlatch_pre(unsigned int D, unsigned int clk, unsigned int pre);
t_latch *test_Dlatch_rst_pre(unsigned int D, unsigned int clk, unsigned int rst, unsigned int pre);
