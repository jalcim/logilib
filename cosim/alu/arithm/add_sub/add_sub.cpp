#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <cmath>
#include <stdio.h>

#include "add_sub_test.h"
#include "add_sub_template.h"
#include "add_sub_macros.h"

using namespace std;

bool run_add_sub_tests()
{
  bool error = false;
#define X(add_sub_name, wire_number) ADD_SUB_TEST<V##add_sub_name##_##wire_number> *add_sub_name##_##wire_number;
  X_ADD_SUB

#undef X

#define X(add_sub_name, wire_number)                                                                                 \
  add_sub_name##_##wire_number = new ADD_SUB_TEST<V##add_sub_name##_##wire_number>(add_sub_test_check, wire_number); \
  error |= add_sub_name##_##wire_number->test(false);                                                                \
  error |= add_sub_name##_##wire_number->test(true);                                                                 \
                                                                                                                     \
  delete add_sub_name##_##wire_number;

  X_ADD_SUB
#undef X

  return (error);
}
