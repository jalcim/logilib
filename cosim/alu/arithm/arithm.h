#ifndef __ARITHM__
#define __ARITHM__

#include "Vadd.h"
#include "Vmulti_add.h"

typedef struct s_arithm t_arithm;
struct s_arithm
{
  Vadd *g_add;
  Vmulti_add *g_multi_add;

  int fd_add;
  int fd_multi_add;
};

int test_multi_add();
int test_add();

int add_test(unsigned int a, unsigned int b, unsigned int cin);
int multi_add_test(unsigned int a, unsigned int b,
		   unsigned int cin, unsigned int sub);

#endif
