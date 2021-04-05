#ifndef ___PARALLEL_GATE__
#define ___PARALLEL_GATE__

#include "Vparallel_gate_buf.h"
#include "Vparallel_gate_not.h"
#include "Vparallel_gate_and.h"
#include "Vparallel_gate_nand.h"
#include "Vparallel_gate_or.h"
#include "Vparallel_gate_nor.h"
#include "Vparallel_gate_xor.h"
#include "Vparallel_gate_xnor.h"

typedef struct s_parallel_gate t_parallel_gate;
struct s_parallel_gate
{
  Vparallel_gate_buf  *g_parallel_gate_buf;
  Vparallel_gate_not  *g_parallel_gate_not;
  Vparallel_gate_and  *g_parallel_gate_and;
  Vparallel_gate_nand *g_parallel_gate_nand;
  Vparallel_gate_or   *g_parallel_gate_or;
  Vparallel_gate_nor  *g_parallel_gate_nor;
  Vparallel_gate_xor  *g_parallel_gate_xor;
  Vparallel_gate_xnor *g_parallel_gate_xnor;

  int fd_parallel_gate_buf;
  int fd_parallel_gate_not;
  int fd_parallel_gate_and;
  int fd_parallel_gate_nand;
  int fd_parallel_gate_or;
  int fd_parallel_gate_nor;
  int fd_parallel_gate_xor;
  int fd_parallel_gate_xnor;
};

int test_parallel_gate_buf(int e1);
int test_parallel_gate_not(int e1);
int test_parallel_gate_and(int e1, int e2);
int test_parallel_gate_nand(int e1, int e2);
int test_parallel_gate_or(int e1, int e2);
int test_parallel_gate_nor(int e1, int e2);
int test_parallel_gate_xor(int e1, int e2);
int test_parallel_gate_xnor(int e1, int e2);

#endif
