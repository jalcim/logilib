#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <iostream>
#include <boost/log/trivial.hpp>

#include "addx.h"
#include "add_sub.h"

using namespace std;

int run_test(const char *const name, bool (*test)())
{
  bool error;
  int fd_addx;

  BOOST_LOG_TRIVIAL(info) << "Arithm test : " << name;

  error = test();

  if (error)
  {
    BOOST_LOG_TRIVIAL(error) << "Arithm error : " << name;
  }
  else
  {
    BOOST_LOG_TRIVIAL(info) << "Arithm test : " << name;
  }

  return (error);
}

bool test_arithm()
{
  return run_test("addx", run_addx_tests) || run_test("add_sub", run_add_sub_tests);
}
