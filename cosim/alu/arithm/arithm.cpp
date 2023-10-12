#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <iostream>
#include <boost/log/trivial.hpp>

#include "addx.h"

using namespace std;

int test_addx()
{
  bool error;
  int fd_addx;

  BOOST_LOG_TRIVIAL(info) << "Arithm test : addx";

  error = run_addx_tests();

  if (error)
  {
    BOOST_LOG_TRIVIAL(error) << "Arithm error : addx";
  }
  else
  {
    BOOST_LOG_TRIVIAL(info) << "Arithm test : addx";
  }

  return (error);
}

bool test_arithm()
{
  return test_addx();
}
