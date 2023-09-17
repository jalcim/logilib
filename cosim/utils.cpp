#include <stdio.h>
#include <stdarg.h>
#include "utils.h"

int get_bit(int value, int bit_num)
{
  return (value & bit_num) >> (bit_num - 1);
}

void dprint_bin(int fd, unsigned int instr, int size)
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

  dprintf(2, "|1\n\n1|Error with input:");

  while (args < input_number)
  {
    name = va_arg(arg_ptr, char *);
    value = va_arg(arg_ptr, int);

    dprintf(2, "|2\n2|%s : ", name);
    dprint_bin(2, value, sizeof(int));

    ++args;
  }

  va_end(arg_ptr);
}

int debug_test_error(int (*test_fn)(), char const *name, char const *log_file)
{
  int error;

  printf("|3\n\n3|# Test %s : ", name);

  error = test_fn();

  // printf("%s", RESTEXT(error));
  if (error && log_file)
  {
    // dprintf(2, "\n\nLogs in %s", log_file);
  }

  return error;
}
