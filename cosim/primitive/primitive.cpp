#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <iostream>

#include "primitive.h"
#include "gate.h"

using namespace std;

int test_gate()
{
  bool error;
  int fd_gate;

  cout << "\n\nPrimitive test : gates" << endl;

  error = run_gates_tests();

  if (error)
  {
    cerr << "\n\nPrimitive error : gates" << endl;
  }

  return (error);
}

void test_primitive()
{
  test_gate();
  //  test_parallele_gate();
}
