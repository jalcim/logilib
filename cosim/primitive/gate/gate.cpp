
#include "gate_utils.h"
#include "gate_template.h"
#include "gate_macros.h"

#include <cmath>
#include <stdio.h>
using namespace std;

bool run_gates_tests()
{
#define X(gate_name, way_number) GATE_TEST<Vgate##gate_name##_##way_number> *gate##gate_name##_##way_number;

  X_GATES

#undef X

  bool error = false;

#define X(gate_name, way_number)                                                                                    \
  gate##gate_name##_##way_number = new GATE_TEST<Vgate##gate_name##_##way_number>(test_msb##gate_name, way_number); \
  gate##gate_name##_##way_number->open_trace();                                                                     \
  error |= gate##gate_name##_##way_number->test();                                                                  \
                                                                                                                    \
  delete gate##gate_name##_##way_number;

  X_GATES
#undef X

  return (error);
}
