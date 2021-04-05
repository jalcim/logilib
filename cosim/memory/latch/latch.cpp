#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include "latch.h"

extern VerilatedContext *contextp;

static t_latch *latch;
int latch_test()
{
  int a, clk, reset;

  //initialization of latch to avoid undefined state
  latch->g_Dlatch->reset = 1;
  latch->g_Dlatch->eval();
  
  a = 0;
  while(a <= 1)
    {
      clk = 0;
      while(clk <= 1)
	{
	  reset = 0;
	  while(reset <= 1)
	    {
	      if (test_Dlatch(a, clk, reset))
		return (-1);
	      ++reset; 
	    }
	  ++clk;
	}
      ++a;
    }
}

void latch_init()
{
  latch = (t_latch *)malloc(sizeof(t_latch));

  latch->g_Dlatch = new VDlatch {contextp};

  latch->fd_Dlatch =
    open("../build/cosim/memory/latch/Dlatch_check",
	 O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);
}

void latch_destruct()
{
  close(latch->fd_Dlatch);

  delete(latch->g_Dlatch);

  free(latch);
}

int test_Dlatch(int a, int clk, int reset)
{
  int test_latch;

  latch->g_Dlatch->a = a;
  latch->g_Dlatch->clk = clk;
  latch->g_Dlatch->reset = reset;
  latch->g_Dlatch->eval();
  
  test_latch = ((latch->g_Dlatch->a && latch->g_Dlatch->clk)
		&& (!reset)) == latch->g_Dlatch->s1;
  
  dprintf(latch->fd_Dlatch,
	  "a=%d, clk=%d, reset=%d, s1=%d, s2=%d | test_Dlatch=%s\n",
	  latch->g_Dlatch->a,
	  latch->g_Dlatch->clk,
	  latch->g_Dlatch->reset,
	  latch->g_Dlatch->s1,
	  latch->g_Dlatch->s2,
	  test_latch ? "OK" : "FAIL");
  
  return (!test_latch);
}
