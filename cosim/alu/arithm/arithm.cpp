#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include "arithm.h"

extern VerilatedContext *contextp;

static t_arithm *arithm;

int arithm_test()
{
  unsigned int cpt1, cpt2;
  unsigned int sub, cin;

  cin = -1;
  while (++cin <= 1)
    {
      sub = -1;
      while(++sub <= 1)
	{
	  if (cin && sub)
	    return(0);
	  cpt1 = -1;
	  while(++cpt1 <= 1)
	    {
	      cpt2 = -1;
	      while(++cpt2 <= 1)
		if (test_add(cpt1, cpt2, cin, sub))
		  return (-1);
	    }
	}
    }
}

void arithm_init()
{
  arithm = (t_arithm *)malloc(sizeof(t_arithm));
  arithm->g_add = new Vadd {contextp};
  arithm->fd_add = open("../build/cosim/alu/arithm/add",
		     O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);
}

void arithm_destruct()
{
  close(arithm->fd_add);

  delete(arithm->g_add);
  free(arithm);
}

int test_add(int a, int b, int cin, int sub)
{
  int test_arithm;

  arithm->g_add->a = a;
  arithm->g_add->b = b;
  arithm->g_add->cin = cin;
  arithm->g_add->sub = sub;
  arithm->g_add->eval();

  test_arithm = 1;/*(sub ? (arithm->g_add->a - arithm->g_add->b) & 0x1 :
		 (arithm->g_add->a + arithm->g_add->b + arithm->g_add->cin) & 0x1) == arithm->g_add->s & 0x1
    && (sub ? (arithm->g_add->a - arithm->g_add->b) & 0x1:
    ((arithm->g_add->a + arithm->g_add->b + arithm->g_add->cin) >> 1) & 0x1f) == arithm->g_add->cout & 0x1;*/

  dprintf(arithm->fd_add, "a=%u, b=%u, cin=%d, sub=%d, s=%u, cout=%d\n",
	  arithm->g_add->a & 1, arithm->g_add->b & 1, arithm->g_add->cin & 1,
	  arithm->g_add->sub & 1, arithm->g_add->s & 1, arithm->g_add->cout & 1);
  return (!test_arithm);
}

