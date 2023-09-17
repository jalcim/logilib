#ifndef __GATE__
#define __GATE__

#define E1 in & 1

#define E2 in & 2

#define GATE_LOG(name) dprintf(gate->fd##name, "E1=%d, E2=%d, out=%d | test_gate%s=%s\n", gate->g##name->in & 1, gate->g##name->in & 2, gate->g##name->out, #name, gate_error ? "FAIL" : "OK");

#define X_GATES \
  X(_not)       \
  X(_buf)       \
  X(_xnor)      \
  X(_and)       \
  X(_nand)      \
  X(_or)        \
  X(_nor)       \
  X(_xor)

#define GENERATE_GATE_TEST_FUNCTION(gate_name, fail_condition) \
  int test_gate##gate_name(int input)                          \
  {                                                            \
    int gate_error;                                            \
                                                               \
    gate->g##gate_name->in = input;                            \
    gate->g##gate_name->eval();                                \
    gate_error = fail_condition;                               \
                                                               \
    GATE_LOG(gate_name);                                       \
                                                               \
    return (gate_error);                                       \
  }

#include "Vgate_buf.h"
#include "Vgate_not.h"
#include "Vgate_and.h"
#include "Vgate_nand.h"
#include "Vgate_or.h"
#include "Vgate_nor.h"
#include "Vgate_xor.h"
#include "Vgate_xnor.h"

typedef struct s_gate t_gate;
struct s_gate
{
#define X(gate_name)              \
  Vgate##gate_name *g##gate_name; \
  int fd##gate_name;

  X_GATES
#undef X
};

#define X(gate_name) int test_gate##gate_name(int input);

X_GATES

#undef X

#endif
