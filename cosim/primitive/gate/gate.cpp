
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include "gate.h"
#include "../../tools/logs.h"

extern VerilatedContext *contextp;

#define X(gate_name) static t_gate##gate_name *gate##gate_name;

X_GATES

#undef X

int run_gates_tests()
{
  int error = 0;

#define X(gate_name) error |= run_test_and_log(test_gate##gate_name, "primitive" #gate_name, GET_LOG_FILE(gate_name));
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

// (out & 1) verilator fix verilog buffer management
GENERATE_GATE_TEST_FUNCTION(_buf, ((gate_buf->gate->E1) != (gate_buf->gate->out & 1)))

GENERATE_GATE_TEST_FUNCTION(_not, ((gate_not->gate->E1) == gate_not->gate->out))

GENERATE_GATE_TEST_FUNCTION(_and, ((gate_and->gate->E1) & ((gate_and->gate->E2) >> 1)) != gate_and->gate->out)

GENERATE_GATE_TEST_FUNCTION(_nand, ((gate_nand->gate->E1) & ((gate_nand->gate->E2) >> 1)) == gate_nand->gate->out)

GENERATE_GATE_TEST_FUNCTION(_or, ((gate_or->gate->E1) | ((gate_or->gate->E2) >> 1)) != gate_or->gate->out)

GENERATE_GATE_TEST_FUNCTION(_nor, ((gate_nor->gate->E1) | ((gate_nor->gate->E2) >> 1)) == gate_nor->gate->out)

GENERATE_GATE_TEST_FUNCTION(_xor, ((gate_xor->gate->E1) ^ ((gate_xor->gate->E2) >> 1)) != gate_xor->gate->out)

GENERATE_GATE_TEST_FUNCTION(_xnor, ((gate_xnor->gate->E1) ^ ((gate_xnor->gate->E2) >> 1)) == gate_xnor->gate->out)
