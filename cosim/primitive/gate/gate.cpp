
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include "gate.h"

extern VerilatedContext *contextp;

static t_gate *gate;

int run_gate_test(int in)
{
  printf("in = %d\n", in);
  //  if (test_gate_buf(in))
  //      || test_gate_not(in))
  //    return (-1);
  if (test_gate_and(in) || test_gate_nand(in) || test_gate_or(in) || test_gate_nor(in) || test_gate_xor(in) || test_gate_xnor(in))
    return (-1);
  return (0);
}

int gate_test()
{
  int in;

  in = 0; // 00
  if (run_gate_test(in))
    return (-1);
  in = 1; // 01
  if (run_gate_test(in))
    return (-1);
  in = 2; // 10
  if (run_gate_test(in))
    return (-1);
  in = 3; // 11
  if (run_gate_test(in))
    return (-1);
  return (0);
}

void gate_init()
{
  gate = (t_gate *)malloc(sizeof(t_gate));

#define X(gate_name)                                   \
  gate->g##gate_name = new Vgate##gate_name{contextp}; \
  gate->fd##gate_name = open("build/cosim/primitive/gate/" #gate_name "_buf_check", O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);

  X_GATES
#undef X
}

void gate_destruct()
{

#define X(gate_name)          \
  close(gate->fd##gate_name); \
  delete gate->g##gate_name;

  X_GATES
#undef X

  free(gate);
}

#define E1 in & 1
#define E2 in & 2

int test_gate_buf(int in)
{
  int gate_error;

  gate->g_buf->in = in;
  gate->g_buf->eval();
  gate_error = ((gate->g_buf->E1) != gate->g_buf->out);

  GATE_LOG(buf);

  return (gate_error);
}

int test_gate_not(int in)
{
  int gate_error;

  gate->g_not->in = in;
  gate->g_not->eval();
  gate_error = ((gate->g_not->E1) == gate->g_not->out);

  GATE_LOG(buf);

  return (gate_error);
}

int test_gate_and(int in)
{
  int gate_error;

  gate->g_and->in = in;
  gate->g_and->eval();
  gate_error = ((gate->g_and->E1) & ((gate->g_and->E2) >> 1)) != gate->g_and->out;

  GATE_LOG(and);

  return (gate_error);
}

int test_gate_nand(int in)
{
  int gate_error;

  gate->g_nand->in = in;
  gate->g_nand->eval();
  gate_error = ((gate->g_nand->E1) & ((gate->g_nand->E2) >> 1)) == gate->g_nand->out;

  GATE_LOG(nand);

  return (gate_error);
}

int test_gate_or(int in)
{
  int gate_error;

  gate->g_or->in = in;
  gate->g_or->eval();
  gate_error = ((gate->g_or->E1) | ((gate->g_or->E2) >> 1)) != gate->g_or->out;

  GATE_LOG(or);

  return (gate_error);
}

int test_gate_nor(int in)
{
  int gate_error;

  gate->g_nor->in = in;
  gate->g_nor->eval();
  gate_error = ((gate->g_nor->E1) | ((gate->g_nor->E2) >> 1)) == gate->g_nor->out;

  GATE_LOG(nor);

  return (gate_error);
}

int test_gate_xor(int in)
{
  int gate_error;

  gate->g_xor->in = in;
  gate->g_xor->eval();
  gate_error = ((gate->g_xor->E1) ^ ((gate->g_xor->E2) >> 1)) != gate->g_xor->out;

  GATE_LOG(xor);

  return (gate_error);
}

int test_gate_xnor(int in)
{
  int gate_error;

  gate->g_xnor->in = in;
  gate->g_xnor->eval();
  gate_error = ((gate->g_xnor->E1) ^ ((gate->g_xnor->E2) >> 1)) == gate->g_xnor->out;

  GATE_LOG(xnor);

  return (gate_error);
}
