#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include "parallel_gate.h"

#define ARCH8BIT
#ifdef ARCH8BIT
#define MASK 0xFFFFFF00
#endif

extern VerilatedContext *contextp;

static t_parallel_gate *parallel_gate;

int parallel_gate_test()
{
  unsigned int cpt1, cpt2;
  unsigned int in1, in2;

  cpt1 = -1;
  in1 = 0;
  while (++cpt1 < 0x100)//1 0000 0000
    {
      if (test_parallel_gate_buf(in1)
	  || test_parallel_gate_not(in1))
	return (-1);
      cpt2 = -1;
      while (++cpt2 < 0x100)
	{
	  in2 = cpt2;
	  if (test_parallel_gate_and(in1, in2)
	      || test_parallel_gate_nand(in1, in2)
	      || test_parallel_gate_or(in1, in2)
	      || test_parallel_gate_nor(in1, in2)	
	      || test_parallel_gate_xor(in1, in2)
	      || test_parallel_gate_xnor(in1, in2))
	    return (-1);
	}
      in1 = cpt1;
    }
  return (0);
}

void parallel_gate_init()
{
  parallel_gate = (t_parallel_gate *)malloc(sizeof(t_parallel_gate));
  parallel_gate->g_parallel_gate_buf =
    new Vparallel_gate_buf {contextp};

  parallel_gate->g_parallel_gate_not =
    new Vparallel_gate_not {contextp};

  parallel_gate->g_parallel_gate_and =
    new Vparallel_gate_and {contextp};
  
  parallel_gate->g_parallel_gate_nand =
    new Vparallel_gate_nand{contextp};

  parallel_gate->g_parallel_gate_or =
    new Vparallel_gate_or  {contextp};

  parallel_gate->g_parallel_gate_nor =
    new Vparallel_gate_nor {contextp};

  parallel_gate->g_parallel_gate_xor =
    new Vparallel_gate_xor {contextp};

  parallel_gate->g_parallel_gate_xnor =
    new Vparallel_gate_xnor{contextp};

  parallel_gate->fd_parallel_gate_buf =
    open("../build/cosim/primitive/parallel_gate/parallel_buf_check",
	 O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);

  parallel_gate->fd_parallel_gate_not =
    open("../build/cosim/primitive/parallel_gate/parallel_not_check",
	 O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);
  
  parallel_gate->fd_parallel_gate_and =
    open("../build/cosim/primitive/parallel_gate/parallel_and_check",
	 O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);
  
  parallel_gate->fd_parallel_gate_nand =
    open("../build/cosim/primitive/parallel_gate/parallel_nand_check",
	 O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);

  parallel_gate->fd_parallel_gate_or =
    open("../build/cosim/primitive/parallel_gate/parallel_or_check",
	 O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);

  parallel_gate->fd_parallel_gate_nor =
    open("../build/cosim/primitive/parallel_gate/parallel_nor_check",
	 O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);

  parallel_gate->fd_parallel_gate_xor =
    open("../build/cosim/primitive/parallel_gate/parallel_xor_check",
	 O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);

  parallel_gate->fd_parallel_gate_xnor =
    open("../build/cosim/primitive/parallel_gate/parallel_xnor_check",
	 O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);

}

void parallel_gate_destruct()
{
  close(parallel_gate->fd_parallel_gate_buf);
  close(parallel_gate->fd_parallel_gate_not);
  close(parallel_gate->fd_parallel_gate_and);
  close(parallel_gate->fd_parallel_gate_nand);
  close(parallel_gate->fd_parallel_gate_or);
  close(parallel_gate->fd_parallel_gate_nor);
  close(parallel_gate->fd_parallel_gate_xor);
  close(parallel_gate->fd_parallel_gate_xnor);

  delete(parallel_gate->g_parallel_gate_buf);
  delete(parallel_gate->g_parallel_gate_not);
  delete(parallel_gate->g_parallel_gate_and);
  delete(parallel_gate->g_parallel_gate_nand);
  delete(parallel_gate->g_parallel_gate_or);
  delete(parallel_gate->g_parallel_gate_nor);
  delete(parallel_gate->g_parallel_gate_xor);
  delete(parallel_gate->g_parallel_gate_xnor);
  free(parallel_gate);
}

int test_parallel_gate_buf(int in1)
{
  int test_gate;

  parallel_gate->g_parallel_gate_buf->in = in1;
  parallel_gate->g_parallel_gate_buf->eval();
  test_gate = (parallel_gate->g_parallel_gate_buf->in
	       == parallel_gate->g_parallel_gate_buf->out);
  dprintf(parallel_gate->fd_parallel_gate_buf,
	  "in=%d, s=%d | test_parallel_gate_buf=%s\n",
	  parallel_gate->g_parallel_gate_buf->in,
	  parallel_gate->g_parallel_gate_buf->out,
	  test_gate ? "OK" : "FAIL");
  return (!test_gate);
}

int test_parallel_gate_not(int in1)
{
  int test_gate;

  parallel_gate->g_parallel_gate_not->in = in1;
  parallel_gate->g_parallel_gate_not->eval();
  test_gate = (parallel_gate->g_parallel_gate_not->in
	       != parallel_gate->g_parallel_gate_not->out);
  dprintf(parallel_gate->fd_parallel_gate_not,
	  "in=%d, s=%d | test_parallel_gate_not=%s\n",
	  parallel_gate->g_parallel_gate_not->in,
	  parallel_gate->g_parallel_gate_not->out,
	  test_gate ? "OK" : "FAIL");
  return (!test_gate);

}

int test_parallel_gate_and(int in1, int in2)
{
  int test_gate;

  parallel_gate->g_parallel_gate_and->in1 = in1;
  parallel_gate->g_parallel_gate_and->in2 = in2;
  
  parallel_gate->g_parallel_gate_and->eval();
  test_gate = (parallel_gate->g_parallel_gate_and->in1
	       & parallel_gate->g_parallel_gate_and->in2)
    == parallel_gate->g_parallel_gate_and->out;
  dprintf(parallel_gate->fd_parallel_gate_and,
	  "in1=%d, in2=%d, s=%d | test_parallel_gate_and=%s\n",
	  parallel_gate->g_parallel_gate_and->in1,
	  parallel_gate->g_parallel_gate_and->in2,
	  parallel_gate->g_parallel_gate_and->out,
	  test_gate ? "OK" : "FAIL");
  return (!test_gate);
}

int test_parallel_gate_nand(int in1, int in2)
{
  int test_gate;

  parallel_gate->g_parallel_gate_nand->in1 = in1;
  parallel_gate->g_parallel_gate_nand->in2 = in2;  
  parallel_gate->g_parallel_gate_nand->eval();
  
  test_gate = ~(parallel_gate->g_parallel_gate_nand->in1
	       & parallel_gate->g_parallel_gate_nand->in2)
    ^ MASK
    == parallel_gate->g_parallel_gate_nand->out;

  dprintf(parallel_gate->fd_parallel_gate_nand,
	  "in1=%d, in2=%d, s=%d | test_parallel_gate_nand=%s\n",
	  parallel_gate->g_parallel_gate_nand->in1,
	  parallel_gate->g_parallel_gate_nand->in2,
	  parallel_gate->g_parallel_gate_nand->out,
	  test_gate ? "OK" : "FAIL");
  return (!test_gate);
}

int test_parallel_gate_or(int in1, int in2)
{
  int test_gate;

  parallel_gate->g_parallel_gate_or->in1 = in1;
  parallel_gate->g_parallel_gate_or->in2 = in2;  
  parallel_gate->g_parallel_gate_or->eval();
  
  test_gate = (parallel_gate->g_parallel_gate_or->in1
	       | parallel_gate->g_parallel_gate_or->in2)
    == parallel_gate->g_parallel_gate_or->out;

  dprintf(parallel_gate->fd_parallel_gate_or,
	  "in1=%d, in2=%d, s=%d | test_parallel_gate_or=%s\n",
	  parallel_gate->g_parallel_gate_or->in1,
	  parallel_gate->g_parallel_gate_or->in2,
	  parallel_gate->g_parallel_gate_or->out,
	  test_gate ? "OK" : "FAIL");
  return (!test_gate);
}

int test_parallel_gate_nor(int in1, int in2)
{
  int test_gate;

  parallel_gate->g_parallel_gate_nor->in1 = in1;
  parallel_gate->g_parallel_gate_nor->in2 = in2;  
  parallel_gate->g_parallel_gate_nor->eval();
  
  test_gate = ~(parallel_gate->g_parallel_gate_nor->in1
	       | parallel_gate->g_parallel_gate_nor->in2)
    ^ MASK
    == parallel_gate->g_parallel_gate_nor->out;

  dprintf(parallel_gate->fd_parallel_gate_nor,
	  "in1=%d, in2=%d, s=%d | test_parallel_gate_nor=%s\n",
	  parallel_gate->g_parallel_gate_nor->in1,
	  parallel_gate->g_parallel_gate_nor->in2,
	  parallel_gate->g_parallel_gate_nor->out,
	  test_gate ? "OK" : "FAIL");
  return (!test_gate);
}

int test_parallel_gate_xor(int in1, int in2)
{
  int test_gate;

  parallel_gate->g_parallel_gate_xor->in1 = in1;
  parallel_gate->g_parallel_gate_xor->in2 = in2;  
  parallel_gate->g_parallel_gate_xor->eval();
  
  test_gate = (parallel_gate->g_parallel_gate_xor->in1
	       ^ parallel_gate->g_parallel_gate_xor->in2)
    == parallel_gate->g_parallel_gate_xor->out;

  dprintf(parallel_gate->fd_parallel_gate_xor,
	  "in1=%d, in2=%d, s=%d | test_parallel_gate_xor=%s\n",
	  parallel_gate->g_parallel_gate_xor->in1,
	  parallel_gate->g_parallel_gate_xor->in2,
	  parallel_gate->g_parallel_gate_xor->out,
	  test_gate ? "OK" : "FAIL");
  return (!test_gate);
}

int test_parallel_gate_xnor(int in1, int in2)
{
  int test_gate;

  parallel_gate->g_parallel_gate_xnor->in1 = in1;
  parallel_gate->g_parallel_gate_xnor->in2 = in2;  
  parallel_gate->g_parallel_gate_xnor->eval();
  
  test_gate = ~(parallel_gate->g_parallel_gate_xnor->in1
	       ^ parallel_gate->g_parallel_gate_xnor->in2)
    ^ MASK
    == parallel_gate->g_parallel_gate_xnor->out;

  dprintf(parallel_gate->fd_parallel_gate_xnor,
	  "in1=%d, in2=%d, s=%d | test_parallel_gate_xnor=%s\n",
	  parallel_gate->g_parallel_gate_xnor->in1,
	  parallel_gate->g_parallel_gate_xnor->in2,
	  parallel_gate->g_parallel_gate_xnor->out,
	  test_gate ? "OK" : "FAIL");
  return (!test_gate);
}
