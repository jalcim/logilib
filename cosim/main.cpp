#include <verilated.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include "main.h"

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
  mkdir("../build/cosim/primitive/parallel_gate", 0777);

  delete(contextp);
}

int test_gate();
int test_parallele_gate();
void test_primitive()
{
  test_gate();
  test_parallele_gate();
  
}

int test_gate()
{
  int test = 0;
  int fd_gate;

  gate_init();
  test = gate_test();
  gate_destruct();
  
  fd_gate = open("../build/cosim/primitive/gate_check",
		      O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);

  printf("primitive-gate test : %s\n", test ? "FAIL" : "OK");
  dprintf(fd_gate, "primitive-gate test : %s\n", test ? "FAIL" : "OK");

  
  close(fd_gate);
  return (test);
}

int test_parallele_gate()
{
  int test = 0;
  int fd_parallel_gate;

  parallel_gate_init();
  test = parallel_gate_test();
  parallel_gate_destruct();
  
  fd_parallel_gate = open("../build/cosim/primitive/parallel_gate_check",
		      O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);

  printf("primitive-parallel_gate test : %s\n", test ? "FAIL" : "OK");
  dprintf(fd_parallel_gate, "primitive-parallel_gate test : %s\n", test ? "FAIL" : "OK");

  
  close(fd_parallel_gate);
  return (test);
}
