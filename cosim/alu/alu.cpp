
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <iostream>
#include <boost/log/trivial.hpp>

#include "arithm.h"

using namespace std;

int test_alu()
{
  bool error;
  int fd_gate;

  BOOST_LOG_TRIVIAL(info) << "Alu test : arithm";

  error = test_arithm();

  if (error)
  {
    BOOST_LOG_TRIVIAL(error) << "Alu error : arithm";
  }
  else
  {
    BOOST_LOG_TRIVIAL(info) << "Alu test : arithm";
  }

  return (error);
}
