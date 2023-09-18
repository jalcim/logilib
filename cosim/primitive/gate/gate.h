#ifndef __GATE__
#define __GATE__

// #include "Vgate_buf.h"
// #include "Vgate_not.h"
#include "Vgate_and.h"
#include "Vgate_nand.h"
#include "Vgate_or.h"
#include "Vgate_nor.h"
#include "Vgate_xor.h"
#include "Vgate_xnor.h"

#define E1 in & 1

#define E2 in & 2

#define GATE_LOG(name) dprintf(                \
    gate##name->fd,                            \
    "E1=%d, E2=%d, out=%d | test_gate%s=%s\n", \
    gate##name->gate->in & 1,                  \
    gate##name->gate->in & 2 >> 1,             \
    gate##name->gate->out,                     \
    #name,                                     \
    gate_error ? "FAIL" : "OK");

// X(_buf)       \
  // X(_not)       \

#define X_GATES \
  X(_xnor)      \
  X(_and)       \
  X(_nand)      \
  X(_or)        \
  X(_nor)       \
  X(_xor)

#define X(gate_name)                                  \
  int test_gate##gate_name(int input);                \
                                                      \
  typedef struct s_gate##gate_name t_gate##gate_name; \
  struct s_gate##gate_name                            \
  {                                                   \
    Vgate##gate_name *gate;                           \
    int fd;                                           \
  };

X_GATES

#undef X

#define GENERATE_GATE_TEST_FUNCTION(gate_name, fail_condition) \
  int test_gate##gate_name(int input)                          \
  {                                                            \
    int gate_error;                                            \
                                                               \
    gate##gate_name->gate->in = input;                         \
    gate##gate_name->gate->eval();                             \
    gate_error = fail_condition;                               \
                                                               \
    GATE_LOG(gate_name);                                       \
                                                               \
    return (gate_error);                                       \
  }

#endif
