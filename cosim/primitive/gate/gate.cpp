#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include "gate.h"

extern VerilatedContext *contextp;

static t_gate *gate;

int gate_test()
{
  int e1, e2;

  e1 = -1;
  while (++e1 <= 1)
    {
      if (test_gate_buf(e1)
	  || test_gate_not(e1))
	return (-1);
      e2 = -1;
      while(++e2 <= 1)
	{
	  if (test_gate_and(e1, e2)
	      || test_gate_nand(e1, e2)
	      || test_gate_or(e1, e2)
	      || test_gate_nor(e1, e2)
	      || test_gate_xor(e1, e2)
	      || test_gate_xnor(e1, e2))
	    return (-1);
	}
    }
}

void gate_init()
{
  gate = (t_gate *) malloc(sizeof(t_gate));
  gate->g_buf  = new Vgate_buf {contextp};
  gate->g_not  = new Vgate_not {contextp};
  gate->g_and  = new Vgate_and {contextp};
  gate->g_nand = new Vgate_nand{contextp};
  gate->g_or   = new Vgate_or  {contextp};
  gate->g_nor  = new Vgate_nor {contextp};
  gate->g_xor  = new Vgate_xor {contextp};
  gate->g_xnor = new Vgate_xnor{contextp};

  gate->fd_buf  = open("../build/cosim/primitive/gate/buf_check",
		       O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);
  gate->fd_not  = open("../build/cosim/primitive/gate/not_check",
		       O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);
  gate->fd_and  = open("../build/cosim/primitive/gate/and_check",
		       O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);
  gate->fd_nand = open("../build/cosim/primitive/gate/nand_check",
		       O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);
  gate->fd_or   = open("../build/cosim/primitive/gate/or_check",
		       O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);
  gate->fd_nor  = open("../build/cosim/primitive/gate/nor_check",
		       O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);
  gate->fd_xor  = open("../build/cosim/primitive/gate/xor_check",
		       O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);
  gate->fd_xnor = open("../build/cosim/primitive/gate/xnor_check",
		       O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);
}

void gate_destruct()
{
  close(gate->fd_buf);
  close(gate->fd_not);
  close(gate->fd_and);
  close(gate->fd_nand);
  close(gate->fd_or);
  close(gate->fd_nor);
  close(gate->fd_xor);
  close(gate->fd_xnor);

  delete gate->g_buf; 
  delete gate->g_not;
  delete gate->g_and;
  delete gate->g_nand;
  delete gate->g_or;
  delete gate->g_nor;
  delete gate->g_xor;
  delete gate->g_xnor;
  free(gate);
}

int test_gate_buf(int e1)
{
  int test_gate;

  gate->g_buf->e1 = e1;
  gate->g_buf->eval();
  test_gate = (gate->g_buf->e1 == gate->g_buf->s);

  dprintf(gate->fd_buf, "e1=%d, s=%d | test_gate_buf=%s\n",
	  gate->g_buf->e1, gate->g_buf->s,
	  test_gate ? "OK" : "FAIL");
  return (!test_gate);
}

int test_gate_not(int e1)
{
  int test_gate;

  gate->g_not->e1 = e1;
  gate->g_not->eval();
  test_gate = (gate->g_not->e1 != gate->g_not->s);
  dprintf(gate->fd_not, "e1=%d, s=%d | test_gate_not=%s\n",
	  gate->g_not->e1, gate->g_not->s,
	  test_gate ? "OK" : "FAIL");
  return (!test_gate);
}

int test_gate_and(int e1, int e2)
{
  int test_gate;

  gate->g_and->e1 = e1;
  gate->g_and->e2 = e2;
  gate->g_and->eval();
  test_gate = (gate->g_and->e1 & gate->g_and->e2) == gate->g_and->s;
  dprintf(gate->fd_and, "e1=%d, e2=%d, s=%d | test_gate_and=%s\n",
	  gate->g_and->e1, gate->g_and->e2, gate->g_and->s,
	  test_gate ? "OK" : "FAIL");
  return (!test_gate);
}

int test_gate_nand(int e1, int e2)
{
  int test_gate;
  
  gate->g_nand->e1 = e1;
  gate->g_nand->e2 = e2;
  gate->g_nand->eval();
  test_gate = (gate->g_nand->e1 & gate->g_nand->e2) != gate->g_nand->s;
  dprintf(gate->fd_nand, "e1=%d, e2=%d, s=%d | test_gate_nand=%s\n",
	  gate->g_nand->e1, gate->g_nand->e2, gate->g_nand->s,
	  test_gate ? "OK" : "FAIL");
  return (!test_gate);
}

int test_gate_or(int e1, int e2)
{
  int test_gate;

  gate->g_or->e1 = e1;
  gate->g_or->e2 = e2;
  gate->g_or->eval();
  test_gate = (gate->g_or->e1 | gate->g_or->e2) == gate->g_or->s ? 1 : 0;
  dprintf(gate->fd_or, "e1=%d, e2=%d, s=%d | test_gate_or=%s\n",
	  gate->g_or->e1, gate->g_or->e2, gate->g_or->s,
	  test_gate ? "OK" : "FAIL");
  return (!test_gate);
}

int test_gate_nor(int e1, int e2)
{
  int test_gate;

  gate->g_nor->e1 = e1;
  gate->g_nor->e2 = e2;
  gate->g_nor->eval();
  test_gate = (gate->g_nor->e1 | gate->g_nor->e2) != gate->g_nor->s;
  dprintf(gate->fd_nor, "e1=%d, e2=%d, s=%d | test_gate_nor=%s\n",
	  gate->g_nor->e1, gate->g_nor->e2, gate->g_nor->s,
	  test_gate ? "OK" : "FAIL");
  return (!test_gate);
}

int test_gate_xor(int e1, int e2)
{
  int test_gate;

  gate->g_xor->e1 = e1;
  gate->g_xor->e2 = e2;
  gate->g_xor->eval();
  test_gate = (gate->g_xor->e1 ^ gate->g_xor->e2) == gate->g_xor->s;
  dprintf(gate->fd_xor, "e1=%d, e2=%d, s=%d | test_gate_xor=%s\n",
	  gate->g_xor->e1, gate->g_xor->e2, gate->g_xor->s,
	  test_gate ? "OK" : "FAIL");
  return (!test_gate);
}

int test_gate_xnor(int e1, int e2)
{
  int test_gate;

  gate->g_xnor->e1 = e1;
  gate->g_xnor->e2 = e2;
  gate->g_xnor->eval();
  test_gate = (gate->g_xnor->e1 ^ gate->g_xnor->e2) != gate->g_xnor->s;
  dprintf(gate->fd_xnor, "e1=%d, e2=%d, s=%d | test_gate_xnor=%s\n",
	  gate->g_xnor->e1, gate->g_xnor->e2, gate->g_xnor->s,
	  test_gate ? "OK" : "FAIL");
  return (!test_gate);
}
