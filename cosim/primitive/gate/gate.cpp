
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include "gate.h"

extern VerilatedContext *contextp;

static t_gate *gate;

int gate_test_log(int fd, int input, int output, char const *name, bool success)
{
  return dprintf(fd, "E1=%d, E2=%d, out=%d | test_gate_%s=%s\n", input & 1, input & 2, output, name, success ? "OK" : "FAIL");
}

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
  int test_gate;

  gate->g_buf->in = in;
  gate->g_buf->eval();
  test_gate = ((gate->g_buf->E1) == gate->g_buf->out);

  GATE_LOG(buf);

  return (!test_gate);
}

int test_gate_not(int in)
{
  int test_gate;

  gate->g_not->in = in;
  gate->g_not->eval();
  test_gate = ((gate->g_not->E1) != gate->g_not->out);

  GATE_LOG(buf);

  return (!test_gate);
}

int test_gate_and(int in)
{
  int test_gate;

  gate->g_and->in = in;
  gate->g_and->eval();
  test_gate = ((gate->g_and->E1) & ((gate->g_and->E2) >> 1)) == gate->g_and->out;

  GATE_LOG(and);

  return (!test_gate);
}

int test_gate_nand(int in)
{
  int test_gate;

  gate->g_nand->in = in;
  gate->g_nand->eval();
  test_gate = ((gate->g_nand->E1) & ((gate->g_nand->E2) >> 1)) != gate->g_nand->out;

  GATE_LOG(nand);

  return (!test_gate);
}

int test_gate_or(int in)
{
  int test_gate;

  gate->g_or->in = in;
  gate->g_or->eval();
  test_gate = ((gate->g_or->E1) | ((gate->g_or->E2) >> 1)) == gate->g_or->out;

  GATE_LOG(or);

  return (!test_gate);
}

int test_gate_nor(int in)
{
  int test_gate;

  gate->g_nor->in = in;
  gate->g_nor->eval();
  test_gate = ((gate->g_nor->E1) | ((gate->g_nor->E2) >> 1)) != gate->g_nor->out;

  GATE_LOG(nor);

  return (!test_gate);
}

int test_gate_xor(int in)
{
  int test_gate;

  gate->g_xor->in = in;
  gate->g_xor->eval();
  test_gate = ((gate->g_xor->E1) ^ ((gate->g_xor->E2) >> 1)) == gate->g_xor->out;

  GATE_LOG(xor);

  return (!test_gate);
}

int test_gate_xnor(int in)
{
  int test_gate;

  gate->g_xnor->in = in;
  gate->g_xnor->eval();
  test_gate = ((gate->g_xnor->E1) ^ ((gate->g_xnor->E2) >> 1)) != gate->g_xnor->out;

  GATE_LOG(xnor);

  return (!test_gate);
}
