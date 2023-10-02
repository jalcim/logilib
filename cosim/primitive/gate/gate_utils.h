#ifndef __COSIM_GATE_UTILS_H__
#define __COSIM_GATE_UTILS_H__

int test_msb_buf(int input, int way_number);
int test_msb_not(int input, int way_number);
int test_msb_and(int input, int way_number);
int test_msb_nand(int input, int way_number);
int test_msb_or(int input, int way_number);
int test_msb_nor(int input, int way_number);
int test_msb_xor(int input, int way_number);
int test_msb_xnor(int input, int way_number);

int test_lsb_buf(int input, int way_number);
int test_lsb_not(int input, int way_number);
int test_lsb_and(int input, int way_number);
int test_lsb_nand(int input, int way_number);
int test_lsb_or(int input, int way_number);
int test_lsb_nor(int input, int way_number);
int test_lsb_xor(int input, int way_number);
int test_lsb_xnor(int input, int way_number);

#endif /* __COSIM_GATE_UTILS_H__ */
