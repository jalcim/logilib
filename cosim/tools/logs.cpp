#include <stdio.h>
#include <unistd.h>
#include <stdarg.h>
#include <iostream>
#include "logs.h"

using namespace std;

int get_bit(long value, unsigned long bit_num)
{
  return (value & (1 << bit_num)) >> bit_num;
}

void dprint_bin(int fd, long value, unsigned long size)
{
  unsigned int mask = 1 << (size - 1);
  while (mask)
  {
    write(fd, mask & value ? "1" : "0", 1);
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

  clog << "\nError with input : ";

  while (args < input_number)
  {
    name = va_arg(arg_ptr, char *);
    value = va_arg(arg_ptr, int);
    if (args)
      clog << " , ";
    clog << name << " : ";
    dprint_bin(2, value, sizeof(int));

    ++args;
  }

  clog << endl;

  va_end(arg_ptr);
}

int run_test_and_log(int (*test_fn)(), char const *name, char const *log_file)
{
  int error;

  cout << "\n# Test " << name << " : " << endl;

  error = test_fn();

  if (!error)
    cout << "ok" << endl;

  if (error && log_file)
  {
    clog << "\nLogs in : " << log_file << endl;
  }

  return error;
}
