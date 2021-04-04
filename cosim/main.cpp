#include <verilated.h>
#include "Vgate_buf.h"
#include "Vgate_not.h"
#include "Vgate_and.h"
#include "Vgate_nand.h"
#include "Vgate_or.h"
#include "Vgate_nor.h"
#include "Vgate_xor.h"
#include "Vgate_xnor.h"
//#include "Vgate.h"

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

typedef struct s_primitive t_primitive;
struct s_primitive
{
  Vgate_buf  *g_buf;
  Vgate_not  *g_not;
  Vgate_and  *g_and;
  Vgate_nand *g_nand;
  Vgate_or   *g_or;
  Vgate_nor  *g_nor;
  Vgate_xor  *g_xor;
  Vgate_xnor *g_xnor;

  int fd_buf, fd_not, fd_and, fd_nand, fd_or, fd_nor, fd_xor, fd_xnor;
};

t_primitive primitive;

VerilatedContext *contextp = new VerilatedContext;

void m_buf(int e1);
void m_not(int e1);
void m_and(int e1, int e2);
void m_nand(int e1, int e2);
void m_or(int e1, int e2);
void m_nor(int e1, int e2);
void m_xor(int e1, int e2);
void m_xnor(int e1, int e2);

void primitive_init();
void primitive_test();
void primitive_destruct();
int main(int argc, char **argv, char **env)
{
  contextp->commandArgs(argc, argv);
 
  //  while (!contextp->gotFinish())

  mkdir("../build", 0777);
  mkdir("../build/cosim/", 0777);
  mkdir("../build/cosim/primitive/", 0777);
  mkdir("../build/cosim/primitive/gate", 0777);

  primitive_init();
  primitive_test();
  primitive_destruct();
}

void primitive_test()
{
  int e1, e2;

  e1 = -1;
  while (++e1 <= 1)
    {
      m_buf(e1);
      m_not(e1);
      e2 = -1;
      while(++e2 <= 1)
	{
	  m_and(e1, e2);
	  m_nand(e1, e2);
	  m_or(e1, e2);
	  m_nor(e1, e2);
	  m_xor(e1, e2);
	  m_xnor(e1, e2);
	}
    }
}

void primitive_init()
{
  primitive.g_buf  = new Vgate_buf {contextp};
  primitive.g_not  = new Vgate_not {contextp};
  primitive.g_and  = new Vgate_and {contextp};
  primitive.g_nand = new Vgate_nand{contextp};
  primitive.g_or   = new Vgate_or  {contextp};
  primitive.g_nor  = new Vgate_nor {contextp};
  primitive.g_xor  = new Vgate_xor {contextp};
  primitive.g_xnor = new Vgate_xnor{contextp};

  primitive.fd_buf  = open("../build/cosim/primitive/gate/buf_out" , O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);
  primitive.fd_not  = open("../build/cosim/primitive/gate/not_out" , O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);
  primitive.fd_and  = open("../build/cosim/primitive/gate/and_out" , O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);
  primitive.fd_nand = open("../build/cosim/primitive/gate/nand_out", O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);
  primitive.fd_or   = open("../build/cosim/primitive/gate/or_out"  , O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);
  primitive.fd_nor  = open("../build/cosim/primitive/gate/nor_out" , O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);
  primitive.fd_xor  = open("../build/cosim/primitive/gate/xor_out" , O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);
  primitive.fd_xnor = open("../build/cosim/primitive/gate/xnor_out", O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);
}

void primitive_destruct()
{
  close(primitive.fd_buf);
  close(primitive.fd_not);
  close(primitive.fd_and);
  close(primitive.fd_nand);
  close(primitive.fd_or);
  close(primitive.fd_nor);
  close(primitive.fd_xor);
  close(primitive.fd_xnor);

  delete primitive.g_buf; 
  delete primitive.g_not;
  delete primitive.g_and;
  delete primitive.g_nand;
  delete primitive.g_or;
  delete primitive.g_nor;
  delete primitive.g_xor;
  delete primitive.g_xnor;
  delete contextp;
}

void m_buf(int e1)
{
  int test;

  primitive.g_buf->e1 = e1;
  primitive.g_buf->eval();
  test = (primitive.g_buf->e1 == primitive.g_buf->s);
  dprintf(primitive.fd_buf, "e1=%d, s=%d | test=%d\n",
	  primitive.g_buf->e1, primitive.g_buf->s, test);
  printf("test gate_buf : %s\n", test ? "OK" : "FAIL");
}

void m_not(int e1)
{
  int test;

  primitive.g_not->e1 = e1;
  primitive.g_not->eval();
  test = (primitive.g_not->e1 != primitive.g_not->s);
  dprintf(primitive.fd_not, "e1=%d, s=%d | test=%d\n",
	  primitive.g_not->e1, primitive.g_not->s, test);
  printf("test gate_not : %s\n", test ? "OK" : "FAIL");	  
}

void m_and(int e1, int e2)
{
  int test;

  primitive.g_and->e1 = e1;
  primitive.g_and->e2 = e2;
  primitive.g_and->eval();
  test = (primitive.g_and->e1 & primitive.g_and->e2) == primitive.g_and->s;
  dprintf(primitive.fd_and, "e1=%d, e2=%d, s=%d | test=%d\n",
	  primitive.g_and->e1, primitive.g_and->e2, primitive.g_and->s, test);
  printf("test gate_and : %s\n", test ? "OK" : "FAIL");
}

void m_nand(int e1, int e2)
{
  int test;
  
  primitive.g_nand->e1 = e1;
  primitive.g_nand->e2 = e2;
  primitive.g_nand->eval();
  test = (primitive.g_nand->e1 & primitive.g_nand->e2) != primitive.g_nand->s;
  dprintf(primitive.fd_nand, "e1=%d, e2=%d, s=%d | test=%d\n",
	  primitive.g_nand->e1, primitive.g_nand->e2, primitive.g_nand->s, test);
  printf("test gate_nand : %s\n", test ? "OK" : "FAIL");
}

void m_or(int e1, int e2)
{
  int test;

  primitive.g_or->e1 = e1;
  primitive.g_or->e2 = e2;
  primitive.g_or->eval();
  test = (primitive.g_or->e1 | primitive.g_or->e2) == primitive.g_or->s ? 1 : 0;
  dprintf(primitive.fd_or, "e1=%d, e2=%d, s=%d | test=%d\n",
	  primitive.g_or->e1, primitive.g_or->e2, primitive.g_or->s, test);
  printf("test gate_or : %s\n", test ? "OK" : "FAIL");
}

void m_nor(int e1, int e2)
{
  int test;

  primitive.g_nor->e1 = e1;
  primitive.g_nor->e2 = e2;
  primitive.g_nor->eval();
  test = (primitive.g_nor->e1 | primitive.g_nor->e2) != primitive.g_nor->s;
  dprintf(primitive.fd_nor, "e1=%d, e2=%d, s=%d | test=%d\n",
	  primitive.g_nor->e1, primitive.g_nor->e2, primitive.g_nor->s, test);
  printf("test gate_nor : %s\n", test ? "OK" : "FAIL");
}

void m_xor(int e1, int e2)
{
  int test;

  primitive.g_xor->e1 = e1;
  primitive.g_xor->e2 = e2;
  primitive.g_xor->eval();
  test = (primitive.g_xor->e1 ^ primitive.g_xor->e2) == primitive.g_xor->s;
  dprintf(primitive.fd_xor, "e1=%d, e2=%d, s=%d | test=%d\n",
	  primitive.g_xor->e1, primitive.g_xor->e2, primitive.g_xor->s, test);
  printf("test gate_xor : %s\n", test ? "OK" : "FAIL");
}

void m_xnor(int e1, int e2)
{
  int test;

  primitive.g_xnor->e1 = e1;
  primitive.g_xnor->e2 = e2;
  primitive.g_xnor->eval();
  test = (primitive.g_xnor->e1 ^ primitive.g_xnor->e2) != primitive.g_xnor->s;
  dprintf(primitive.fd_xnor, "e1=%d, e2=%d, s=%d | test=%d\n",
	  primitive.g_xnor->e1, primitive.g_xnor->e2, primitive.g_xnor->s, test);
  printf("test gate_xnor : %s\n", test ? "OK" : "FAIL");
}