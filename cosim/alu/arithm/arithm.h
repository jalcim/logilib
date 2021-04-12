#ifndef __ARITHM__
#define __ARITHM__

#include "Vadd.h"

typedef struct s_arithm t_arithm;
struct s_arithm
{
  Vadd *g_add;

  int fd_add;
};

int test_add(int a, int b, int cin, int sub);
void arithm_init();
int arithm_test();
void arithm_destruct();

#endif
