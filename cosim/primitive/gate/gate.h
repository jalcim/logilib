#ifndef __PRIMITIVE__
#define __PRIMITIVE__

#include "Vgate_buf.h"
#include "Vgate_not.h"
#include "Vgate_and.h"
#include "Vgate_nand.h"
#include "Vgate_or.h"
#include "Vgate_nor.h"
#include "Vgate_xor.h"
#include "Vgate_xnor.h"

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

int m_buf(int e1);
int m_not(int e1);
int m_and(int e1, int e2);
int m_nand(int e1, int e2);
int m_or(int e1, int e2);
int m_nor(int e1, int e2);
int m_xor(int e1, int e2);
int m_xnor(int e1, int e2);

void primitive_init();
int primitive_test();
void primitive_destruct();

#endif
