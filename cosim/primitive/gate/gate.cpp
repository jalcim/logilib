
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include "gate.h"
#include "../../utils.h"

extern VerilatedContext *contextp;

#define X(gate_name) static t_gate##gate_name *gate##gate_name;

X_GATES

#undef X

int run_gates_tests()
{
  int input;
  int error;

  //  if (test_gate_buf(in))
  //      || test_gate_not(in))
  //    return (-1);
#define X(gate_name) error |= run_test_and_log(test_gate##gate_name, #gate_name, GET_LOG_FILE(gate_name));
  X_GATES
#undef X

  return (error);
}

void gates_init()
{

#define X(gate_name)                                                        \
  gate##gate_name = (t_gate##gate_name *)malloc(sizeof(t_gate##gate_name)); \
  gate##gate_name->gate = new Vgate##gate_name{contextp};                   \
  gate##gate_name->fd = open(GET_LOG_FILE(gate_name), O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);

  X_GATES
#undef X
}

void gates_destruct()
{

#define X(gate_name)          \
  close(gate##gate_name->fd); \
  free(gate##gate_name->gate);

  X_GATES
#undef X
}

// GENERATE_GATE_TEST_FUNCTION(_buf, ((gate->g_buf->E1) != gate->g_buf->out))

// GENERATE_GATE_TEST_FUNCTION(_not, ((gate->g_not->E1) == gate->g_not->out))

GENERATE_GATE_TEST_FUNCTION(_and, ((gate_and->gate->E1) & ((gate_and->gate->E2) >> 1)) != gate_and->gate->out)

GENERATE_GATE_TEST_FUNCTION(_nand, ((gate_nand->gate->E1) & ((gate_nand->gate->E2) >> 1)) == gate_nand->gate->out)

GENERATE_GATE_TEST_FUNCTION(_or, ((gate_or->gate->E1) | ((gate_or->gate->E2) >> 1)) == gate_or->gate->out)

GENERATE_GATE_TEST_FUNCTION(_nor, ((gate_nor->gate->E1) | ((gate_nor->gate->E2) >> 1)) == gate_nor->gate->out)

GENERATE_GATE_TEST_FUNCTION(_xor, ((gate_xor->gate->E1) ^ ((gate_xor->gate->E2) >> 1)) != gate_xor->gate->out)

GENERATE_GATE_TEST_FUNCTION(_xnor, ((gate_xnor->gate->E1) ^ ((gate_xnor->gate->E2) >> 1)) == gate_xnor->gate->out)
