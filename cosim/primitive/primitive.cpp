#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

#include "primitive.h"
#include "./gate/gate.h"

int test_gate()
{
  int test = 0;
  int fd_gate;

  gates_init();
  test = run_gates_tests();
  gates_destruct();

  fd_gate = open("build/cosim/primitive/gate_check",
                 O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);

  printf("\nprimitive-gate test : %s\n", test ? "FAIL" : "OK");
  dprintf(fd_gate, "\nprimitive-gate test : %s\n", test ? "FAIL" : "OK");

  close(fd_gate);
  return (test);
}

void test_primitive()
{
  test_gate();
  //  test_parallele_gate();
}
