#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <iostream>
#include <boost/log/trivial.hpp>

#include "primitive.h"
#include "gate.h"

using namespace std;

int test_gate()
{
  bool error;
  int fd_gate;

  BOOST_LOG_TRIVIAL(info) << "Primitive test : gates";

  error = run_gates_tests();

  if (error)
  {
    BOOST_LOG_TRIVIAL(error) << "Primitive error : gates";
  }
  else
  {
    BOOST_LOG_TRIVIAL(info) << "Primitive test : gates";
  }

  return (error);
}

void test_primitive()
{
  test_gate();
  //  test_parallele_gate();
}
