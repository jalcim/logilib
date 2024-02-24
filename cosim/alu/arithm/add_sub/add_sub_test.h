#ifndef __COSIM_ADD_SUB_TEST_H__
#define __COSIM_ADD_SUB_TEST_H__

typedef void(t_add_sub_test)(unsigned int *results, unsigned int max_int, int operandA, int operandB, unsigned int cin, unsigned int sub, unsigned int nb_wires);

t_add_sub_test add_sub_test_check;

#endif /* __COSIM_ADD_SUB_TEST_H__ */
