#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

#include "primitive.h"
#include "./gate/gate.h"

int test_gate()
{
  int error = 0;
  int fd_gate;

  printf("\nprimitive-gate test :");

  gates_init();
  error = run_gates_tests();
  gates_destruct();

  if (error)
  {
    dprintf(2, "primitive-gate error : %d", error);
  }

  return (error);
}

void test_primitive()
{
  test_gate();
  //  test_parallele_gate();
}
