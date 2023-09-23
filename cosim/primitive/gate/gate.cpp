
#include "Vgate_buf.h"
#include "Vgate_not.h"
#include "Vgate_and.h"
#include "Vgate_nand.h"
#include "Vgate_or.h"
#include "Vgate_nor.h"
#include "Vgate_xor.h"
#include "Vgate_xnor.h"
#include "gate.h"

#define X(gate_name, test_condition)         \
  bool test_gate##gate_name(int in, int out) \
  {                                          \
    return test_condition;                   \
  }

X_GATES
#undef X

bool run_gates_tests()
{
#define X(gate_name, test) GATE_TEST<Vgate##gate_name> *gate##gate_name;

  X_GATES

#undef X

  bool error = false;

#define X(gate_name, test_condition)                    \
  gate##gate_name = new GATE_TEST<Vgate##gate_name>();  \
                                                        \
  error |= gate##gate_name->test(test_gate##gate_name); \
                                                        \
  delete gate##gate_name;

  X_GATES
#undef X

  return (error);
}
