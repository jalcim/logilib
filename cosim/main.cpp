#include <verilated.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <fstream>
#include <boost/log/core.hpp>
#include <boost/log/trivial.hpp>
#include <boost/log/expressions.hpp>
#include <boost/log/utility/setup/from_stream.hpp>
#include "./primitive/primitive.h"
#include "main.h"

VerilatedContext *contextp;

void init(int argc, char **argv);
void test_primitive();
void test_memory();
int test_alu();

int main(int argc, char **argv, char **env)
{
  init(argc, argv);
  test_primitive();
  //  test_memory();
  //  test_alu();
  delete (contextp);
}

void init(int argc, char **argv)
{
  contextp = new VerilatedContext;
  contextp->commandArgs(argc, argv);
  std::ifstream file("./cosim/settings.ini");
  boost::log::init_from_stream(file);
  boost::log::core::get()->set_filter(
      boost::log::trivial::severity >= boost::log::trivial::LOG_LEVEL);

  mkdir("build", 0777);
  mkdir("build/cosim", 0777);

  mkdir("build/cosim/primitive", 0777);
  mkdir("build/cosim/primitive/gate", 0777);
  //  mkdir("build/cosim/primitive/parallel_gate", 0777);
}
