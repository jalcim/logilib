
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
  if (
#define X(gate_name) test_gate##gate_name(in) ||

      X_GATES
#undef X
      || false)
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
  gate->fd##gate_name = open("build/cosim/primitive/gate/gate" #gate_name "_check", O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);

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

GENERATE_GATE_TEST_FUNCTION(_buf, ((gate->g_buf->E1) != gate->g_buf->out))

GENERATE_GATE_TEST_FUNCTION(_not, ((gate->g_not->E1) == gate->g_not->out))

GENERATE_GATE_TEST_FUNCTION(_and, ((gate->g_and->E1) & ((gate->g_and->E2) >> 1)) != gate->g_and->out)

GENERATE_GATE_TEST_FUNCTION(_nand, ((gate->g_nand->E1) & ((gate->g_nand->E2) >> 1)) == gate->g_nand->out)

GENERATE_GATE_TEST_FUNCTION(_or, ((gate->g_or->E1) | ((gate->g_or->E2) >> 1)) != gate->g_or->out)

GENERATE_GATE_TEST_FUNCTION(_nor, ((gate->g_nor->E1) | ((gate->g_nor->E2) >> 1)) == gate->g_nor->out)

GENERATE_GATE_TEST_FUNCTION(_xor, ((gate->g_xor->E1) ^ ((gate->g_xor->E2) >> 1)) != gate->g_xor->out)

GENERATE_GATE_TEST_FUNCTION(_xnor, ((gate->g_xnor->E1) ^ ((gate->g_xnor->E2) >> 1)) == gate->g_xnor->out)
