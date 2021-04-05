#ifndef __GATE__
#define __GATE__

#include "Vgate_buf.h"
#include "Vgate_not.h"
#include "Vgate_and.h"
#include "Vgate_nand.h"
#include "Vgate_or.h"
#include "Vgate_nor.h"
#include "Vgate_xor.h"
#include "Vgate_xnor.h"

typedef struct s_gate t_gate;
struct s_gate
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

int test_gate_buf(int e1);
int test_gate_not(int e1);
int test_gate_and(int e1, int e2);
int test_gate_nand(int e1, int e2);
int test_gate_or(int e1, int e2);
int test_gate_nor(int e1, int e2);
int test_gate_xor(int e1, int e2);
int test_gate_xnor(int e1, int e2);

#endif
