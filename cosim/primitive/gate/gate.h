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

#define X_GATES \
  X(_xnor)      \
  X(_and)       \
  X(_nand)      \
  X(_or)        \
  X(_nor)       \
  X(_xor)
// X(_buf)       \
// X(_not)       \

#define E1 in & 1

#define E2 in & 2

#define GET_LOG_FILE(gate_name) "build/cosim/primitive/gate/gate" #gate_name "_check"

#define GATE_LOG(gate_name) dprintf(           \
    gate##gate_name->fd,                       \
    "E1=%d, E2=%d, out=%d | test_gate%s=%s\n", \
    gate##gate_name->gate->E1,                 \
    gate##gate_name->gate->E2 >> 1,            \
    gate##gate_name->gate->out,                \
    #gate_name,                                \
    RESTEXT(gate_error));

#define X(gate_name)                                  \
  int test_gate##gate_name();                         \
                                                      \
  typedef struct s_gate##gate_name t_gate##gate_name; \
  struct s_gate##gate_name                            \
  {                                                   \
    Vgate##gate_name *gate;                           \
    int fd;                                           \
  };

X_GATES

#undef X

#define GENERATE_GATE_TEST_FUNCTION(gate_name, fail_condition)                    \
  int test_gate##gate_name()                                                      \
  {                                                                               \
    int input;                                                                    \
    int gate_error;                                                               \
    int final_error = 0;                                                          \
                                                                                  \
    while (input < 4)                                                             \
    {                                                                             \
      gate##gate_name->gate->in = input;                                          \
      gate##gate_name->gate->eval();                                              \
      gate_error = fail_condition;                                                \
      final_error |= gate_error << input;                                         \
                                                                                  \
      if (gate_error)                                                             \
      {                                                                           \
        debug_input_error(2, "In1", get_bit(input, 1), "In2", get_bit(input, 2)); \
      }                                                                           \
                                                                                  \
      input++;                                                                    \
    }                                                                             \
                                                                                  \
    GATE_LOG(gate_name);                                                          \
                                                                                  \
    return (gate_error);                                                          \
  }

#endif
