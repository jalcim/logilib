#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <cmath>
#include <stdio.h>

#include "addx_test.h"
#include "addx_template.h"
#include "addx_macros.h"

using namespace std;

bool run_addx_tests()
{
  bool error = false;
#define X(addx_name, wire_number) ADDX_TEST<V##addx_name##_##wire_number> *addx_name##_##wire_number;

  X_ADDX

#undef X

#define X(addx_name, wire_number)                                                                        \
  addx_name##_##wire_number = new ADDX_TEST<V##addx_name##_##wire_number>(addx_test_check, wire_number); \
  error |= addx_name##_##wire_number->test();                                                            \
                                                                                                         \
  delete addx_name##_##wire_number;

  X_ADDX
#undef X

  return (error);
}
