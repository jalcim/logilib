#include <verilated.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include "primitive/primitive.h"

VerilatedContext *contextp;

void init(int argc, char **argv);
void test_primitive();
int main(int argc, char **argv, char **env)
{
  init(argc, argv);
  test_primitive();
}

void init(int argc, char **argv)
{
  contextp = new VerilatedContext;
  contextp->commandArgs(argc, argv);
  
  mkdir("../build", 0777);
  mkdir("../build/cosim/", 0777);
  mkdir("../build/cosim/primitive/", 0777);
  mkdir("../build/cosim/primitive/gate", 0777);
}

void test_primitive()
{
  int test;
  int fd_prim_gate;

  primitive_init();
  test = primitive_test();
  primitive_destruct();
  
  fd_prim_gate = open("../build/cosim/primitive/gate_check",
		      O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);

  printf("primitive-gate test : %s\n", test ? "FAIL" : "OK");
  dprintf(fd_prim_gate, "primitive-gate test : %s\n", test ? "FAIL" : "OK");

  close(fd_prim_gate);
}
