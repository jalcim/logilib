#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <iostream>

#include "primitive.h"
#include "./gate/gate.h"

using namespace std;

int test_gate()
{
  int error = 0;
  int fd_gate;

  cout << "\nprimitive-gate test :" << endl;

  gates_init();
  error = run_gates_tests();
  gates_destruct();

  if (error)
  {
    clog << "primitive-gate error :" << error << endl;
  }

  return (error);
}

void test_primitive()
{
  test_gate();
  //  test_parallele_gate();
}
