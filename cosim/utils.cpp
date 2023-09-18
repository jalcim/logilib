#include <stdio.h>
#include <stdarg.h>
#include "utils.h"

int get_bit(long value, unsigned long bit_num)
{
  return (value & (1 << bit_num)) >> (bit_num - 1);
}

void dprint_bin(int fd, long value, unsigned long size)
{
  unsigned int mask = 1 << (size - 1);
  int cpt;

  cpt = -1;
  while (++cpt < size)
  {
    dprintf(fd, "%d", mask & instr ? 1 : 0);
    mask >>= 1;
  }
}

void debug_input_error(int input_number, ...)
{
  va_list arg_ptr;
  int args = 0;
  char const *name;
  int value;

  va_start(arg_ptr, input_number);

  dprintf(2, "\n\nError with input:");

  while (args < input_number)
  {
    name = va_arg(arg_ptr, char *);
    value = va_arg(arg_ptr, int);

    dprintf(2, "\n%s : ", name);
    dprint_bin(2, value, sizeof(int));

    ++args;
  }

  va_end(arg_ptr);
}

int debug_test_error(int (*test_fn)(), char const *name, char const *log_file)
{
  int error;

  printf("\n\n# Test %s : ", name);

  error = test_fn();

  printf("%s", RESTEXT(error));
  if (error && log_file)
  {
    dprintf(2, "\n\nLogs in %s", log_file);
  }

  return error;
}
