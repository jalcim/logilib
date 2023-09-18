#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

#include "primitive.h"
#include "./gate/gate.h"
#include "../tools/logs.h"

int test_gate()
{
  int error = 0;
  int fd_gate;

  gates_init();
  error = run_gates_tests();
  gates_destruct();

  printf("\nprimitive-gate test : %s\n", RESTEXT(error));

  return (error);
}

void test_primitive()
{
  test_gate();
  //  test_parallele_gate();
}
