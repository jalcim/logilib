#include <stdio.h>

#ifndef __COSIM_UTILS_H__
#define __COSIM_UTILS_H__

#define RESTEXT(error) error ? "fail" : "ok"

int get_bit(int value, int bit_num);

void dprint_bin(int fd, unsigned int instr, int size);

void debug_input_error(int input_number, ...);

int debug_test_error(int (*test_fn)(), char const *name, char const *log_file);

#endif /* __COSIM_UTILS_H__ */
