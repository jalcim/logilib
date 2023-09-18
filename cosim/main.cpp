#include <verilated.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

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
  delete(contextp);
}

void init(int argc, char **argv)
{
  contextp = new VerilatedContext;
  contextp->commandArgs(argc, argv);

  mkdir("build", 0777);
  mkdir("build/cosim", 0777);

  mkdir("build/cosim/primitive", 0777);
  mkdir("build/cosim/primitive/gate", 0777);
  //  mkdir("build/cosim/primitive/parallel_gate", 0777);
}
