#ifndef ___PARALLEL_GATE__
#define ___PARALLEL_GATE__

#include "VDlatch.h"

typedef struct s_latch t_latch;
struct s_latch
{
  VDlatch *g_Dlatch;

  int fd_Dlatch;
};

int test_Dlatch(int a, int clk, int reset);

#endif
