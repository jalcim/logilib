#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include "arithm.h"

extern VerilatedContext *contextp;

static t_arithm *arithm;

int arithm_test()
{
  if (test_add()
      || test_multi_add())
    return (-1);
}

int test_multi_add()
{
  unsigned int cpt1, cpt2;
  unsigned int cin, sub;

  sub = 0;
  while (sub <= 1)
    {
      cin = 0;
      while (cin <= 1)
	{
	  cpt1 = 0;
	  while (cpt1 <= 255)
	    {
	      cpt2 = 0;
	      while (cpt2 <= 255)
		{
		  if (multi_add_test(cpt1, cpt2, cin, sub))
		    return (-1);
		  cpt2++;
		}
	      cpt1++;
	    }
	  cin++;
	}
      sub++;
    }
}

int test_add()
{
  unsigned int cpt1, cpt2;
  unsigned int cin;

  cin = 0;
  while (cin <= 1)
    {
      cpt1 = 0;
      while(cpt1 <= 1)
	{
	  cpt2 = 0;
	  while(cpt2 <= 1)
	    {
	      if (add_test(cpt1, cpt2, cin))
		return (-1);
	      cpt2++;
	    }
	  cpt1++;
	}
      cin++;
    }
}

void arithm_init()
{
  arithm = (t_arithm *)malloc(sizeof(t_arithm));
  arithm->g_add = new Vadd {contextp};
  arithm->g_multi_add = new Vmulti_add {contextp};

  arithm->fd_add = open("../build/cosim/alu/arithm/add",
		     O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);
  arithm->fd_multi_add = open("../build/cosim/alu/arithm/multi_add",
		     O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);
}

void arithm_destruct()
{
  close(arithm->fd_add);
  close(arithm->fd_multi_add);
  
  delete(arithm->g_add);
  delete(arithm->g_multi_add);
  free(arithm);
}

int add_test(unsigned int a, unsigned int b, unsigned int cin)
{
  unsigned int test_arithm;

  arithm->g_add->a = a & 0x1;
  arithm->g_add->b = b & 0x1;
  arithm->g_add->cin = cin & 0x1;
  arithm->g_add->eval();

  test_arithm = ((arithm->g_add->a & 0x1) + (arithm->g_add->b & 0x1)
    + (arithm->g_add->cin & 0x1) & 0x1) == (arithm->g_add->s & 0x1)
    &&
    ((((arithm->g_add->a & 0x1) + (arithm->g_add->b & 0x1)
       + (arithm->g_add->cin & 0x1)) >> 1) & 0x1) == (arithm->g_add->cout & 0x1);

  dprintf(arithm->fd_add,
	  "a=%u, b=%u, cin=%d, s=%u, cout=%d\n",
	  arithm->g_add->a & 0x1, arithm->g_add->b & 0x1,
	  arithm->g_add->cin & 0x1, arithm->g_add->s & 0x1,
	  arithm->g_add->cout & 0x1);
  return (!test_arithm);
}

int multi_add_test(unsigned int a, unsigned int b,
		   unsigned int cin, unsigned int sub)
{
  unsigned int test_arithm;

  arithm->g_multi_add->a = a & 0xff;
  arithm->g_multi_add->b = b & 0xff;
  arithm->g_multi_add->cin = cin & 0x1;
  arithm->g_multi_add->sub = sub & 0x1;
  arithm->g_multi_add->eval();

  test_arithm = sub ? ((((arithm->g_multi_add->a & 0xff)
			 - (arithm->g_multi_add->b & 0xff)) & 0xff)
		       == (arithm->g_multi_add->s & 0xff)) :
    ((((arithm->g_multi_add->a & 0xff)
       + (arithm->g_multi_add->b & 0xff)
       + (arithm->g_multi_add->cin & 0xff)) & 0xff)
     == (arithm->g_multi_add->s & 0xff))

    && (((((arithm->g_multi_add->a & 0xff)
		   + (arithm->g_multi_add->b & 0xff)
		   + (arithm->g_multi_add->cin & 0xff)) >> 8) & 0xff)
		== (arithm->g_multi_add->cout & 0xff));

  dprintf(arithm->fd_multi_add,
	  "a=%u, b=%u, cin=%d, sub=%u, s=%u, cout=%d\n",
	  arithm->g_multi_add->a & 0xff, arithm->g_multi_add->b & 0xff,
	  arithm->g_multi_add->cin & 0x1, arithm->g_multi_add->sub & 0x1,
	  arithm->g_multi_add->s & 0xff, arithm->g_multi_add->cout & 0x1);

  return (!test_arithm);
}
