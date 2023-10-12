#ifndef __COSIM_GATE_UTILS_H__
#define __COSIM_GATE_UTILS_H__

typedef void(t_addx_test)(unsigned int *results, unsigned int max_int, unsigned int operandA, unsigned int operandB, unsigned int cin, unsigned int nb_wires);

t_addx_test addx_test_check;

#endif /* __COSIM_GATE_UTILS_H__ */
