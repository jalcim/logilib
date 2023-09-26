#ifndef __COSIM_GATE_MACROS_H__
#define __COSIM_GATE_MACROS_H__
#include "gate_includes.h"

#define RESTEXT(error) (error ? "fail" : "success")

const int get_bit_bitmasks[16] = {
    1,
    2,
    4,
    8,
    16,
    32,
    64,
    128,
    256,
    512,
    1024,
    2048,
    4096,
    16384,
    32768,
    65536,
};

const int get_n_bits_bitmasks[16] = {
    1,
    3,
    7,
    15,
    31,
    63,
    127,
    255,
    511,
    1023,
    2047,
    4095,
    8191,
    16383,
    32768,
    65535,
};

#define GET_BIT(integer, bit_number) ((integer & (get_bit_bitmasks[bit_number])) >> bit_number)

#define X_GATES \
  X(_buf, 1)    \
  X(_not, 1)    \
  X(_and, 2)    \
  X(_nand, 2)   \
  X(_or, 2)     \
  X(_nor, 2)    \
  X(_xor, 2)    \
  X(_xnor, 2)   \
  X(_and, 3)    \
  X(_nand, 3)   \
  X(_or, 3)     \
  X(_nor, 3)    \
  X(_xor, 3)    \
  X(_xnor, 3)   \
  X(_and, 4)    \
  X(_nand, 4)   \
  X(_or, 4)     \
  X(_nor, 4)    \
  X(_xor, 4)    \
  X(_xnor, 4)   \
  X(_and, 5)    \
  X(_nand, 5)   \
  X(_or, 5)     \
  X(_nor, 5)    \
  X(_xor, 5)    \
  X(_xnor, 5)   \
  X(_and, 6)    \
  X(_nand, 6)   \
  X(_or, 6)     \
  X(_nor, 6)    \
  X(_xor, 6)    \
  X(_xnor, 6)   \
  X(_and, 7)    \
  X(_nand, 7)   \
  X(_or, 7)     \
  X(_nor, 7)    \
  X(_xor, 7)    \
  X(_xnor, 7)   \
  X(_and, 8)    \
  X(_nand, 8)   \
  X(_or, 8)     \
  X(_nor, 8)    \
  X(_xor, 8)    \
  X(_xnor, 8)   \
  // X(_and, 9)    \
  // X(_nand, 9)   \
  // X(_or, 9)     \
  // X(_nor, 9)    \
  // X(_xor, 9)    \
  // X(_xnor, 9)   \
  // X(_and, 10)   \
  // X(_nand, 10)  \
  // X(_or, 10)    \
  // X(_nor, 10)   \
  // X(_xor, 10)   \
  // X(_xnor, 10)  \
  // X(_and, 11)   \
  // X(_nand, 11)  \
  // X(_or, 11)    \
  // X(_nor, 11)   \
  // X(_xor, 11)   \
  // X(_xnor, 11)  \
  // X(_and, 12)   \
  // X(_nand, 12)  \
  // X(_or, 12)    \
  // X(_nor, 12)   \
  // X(_xor, 12)   \
  // X(_xnor, 12)  \
  // X(_and, 13)   \
  // X(_nand, 13)  \
  // X(_or, 13)    \
  // X(_nor, 13)   \
  // X(_xor, 13)   \
  // X(_xnor, 13)  \
  // X(_and, 14)   \
  // X(_nand, 14)  \
  // X(_or, 14)    \
  // X(_nor, 14)   \
  // X(_xor, 14)   \
  // X(_xnor, 14)  \
  // X(_and, 15)   \
  // X(_nand, 15)  \
  // X(_or, 15)    \
  // X(_nor, 15)   \
  // X(_xor, 15)   \
  // X(_xnor, 15)  \
  // X(_and, 16)   \
  // X(_nand, 16)  \
  // X(_or, 16)    \
  // X(_nor, 16)   \
  // X(_xor, 16)   \
  // X(_xnor, 16)  \
  // X(_and, 17)   \
  // X(_nand, 17)  \
  // X(_or, 17)    \
  // X(_nor, 17)   \
  // X(_xor, 17)   \
  // X(_xnor, 17)  \
  // X(_and, 18)   \
  // X(_nand, 18)  \
  // X(_or, 18)    \
  // X(_nor, 18)   \
  // X(_xor, 18)   \
  // X(_xnor, 18)  \
  // X(_and, 19)   \
  // X(_nand, 19)  \
  // X(_or, 19)    \
  // X(_nor, 19)   \
  // X(_xor, 19)   \
  // X(_xnor, 19)  \
  // X(_and, 20)   \
  // X(_nand, 20)  \
  // X(_or, 20)    \
  // X(_nor, 20)   \
  // X(_xor, 20)   \
  // X(_xnor, 20)  \
  // X(_and, 21)   \
  // X(_nand, 21)  \
  // X(_or, 21)    \
  // X(_nor, 21)   \
  // X(_xor, 21)   \
  // X(_xnor, 21)  \
  // X(_and, 22)   \
  // X(_nand, 22)  \
  // X(_or, 22)    \
  // X(_nor, 22)   \
  // X(_xor, 22)   \
  // X(_xnor, 22)  \
  // X(_and, 23)   \
  // X(_nand, 23)  \
  // X(_or, 23)    \
  // X(_nor, 23)   \
  // X(_xor, 23)   \
  // X(_xnor, 23)  \
  // X(_and, 24)   \
  // X(_nand, 24)  \
  // X(_or, 24)    \
  // X(_nor, 24)   \
  // X(_xor, 24)   \
  // X(_xnor, 24)  \
  // X(_and, 25)   \
  // X(_nand, 25)  \
  // X(_or, 25)    \
  // X(_nor, 25)   \
  // X(_xor, 25)   \
  // X(_xnor, 25)  \
  // X(_and, 26)   \
  // X(_nand, 26)  \
  // X(_or, 26)    \
  // X(_nor, 26)   \
  // X(_xor, 26)   \
  // X(_xnor, 26)  \
  // X(_and, 27)   \
  // X(_nand, 27)  \
  // X(_or, 27)    \
  // X(_nor, 27)   \
  // X(_xor, 27)   \
  // X(_xnor, 27)  \
  // X(_and, 28)   \
  // X(_nand, 28)  \
  // X(_or, 28)    \
  // X(_nor, 28)   \
  // X(_xor, 28)   \
  // X(_xnor, 28)  \
  // X(_and, 29)   \
  // X(_nand, 29)  \
  // X(_or, 29)    \
  // X(_nor, 29)   \
  // X(_xor, 29)   \
  // X(_xnor, 29)  \
  // X(_and, 30)   \
  // X(_nand, 30)  \
  // X(_or, 30)    \
  // X(_nor, 30)   \
  // X(_xor, 30)   \
  // X(_xnor, 30)  \
  // X(_and, 31)   \
  // X(_nand, 31)  \
  // X(_or, 31)    \
  // X(_nor, 31)   \
  // X(_xor, 31)   \
  // X(_xnor, 31)  \
  // X(_and, 32)   \
  // X(_nand, 32)  \
  // X(_or, 32)    \
  // X(_nor, 32)   \
  // X(_xor, 32)   \
  // X(_xnor, 32)  \
  // X(_and, 33)   \
  // X(_nand, 33)  \
  // X(_or, 33)    \
  // X(_nor, 33)   \
  // X(_xor, 33)   \
  // X(_xnor, 33)  \
  // X(_and, 34)   \
  // X(_nand, 34)  \
  // X(_or, 34)    \
  // X(_nor, 34)   \
  // X(_xor, 34)   \
  // X(_xnor, 34)  \
  // X(_and, 35)   \
  // X(_nand, 35)  \
  // X(_or, 35)    \
  // X(_nor, 35)   \
  // X(_xor, 35)   \
  // X(_xnor, 35)  \
  // X(_and, 36)   \
  // X(_nand, 36)  \
  // X(_or, 36)    \
  // X(_nor, 36)   \
  // X(_xor, 36)   \
  // X(_xnor, 36)  \
  // X(_and, 37)   \
  // X(_nand, 37)  \
  // X(_or, 37)    \
  // X(_nor, 37)   \
  // X(_xor, 37)   \
  // X(_xnor, 37)  \
  // X(_and, 38)   \
  // X(_nand, 38)  \
  // X(_or, 38)    \
  // X(_nor, 38)   \
  // X(_xor, 38)   \
  // X(_xnor, 38)  \
  // X(_and, 39)   \
  // X(_nand, 39)  \
  // X(_or, 39)    \
  // X(_nor, 39)   \
  // X(_xor, 39)   \
  // X(_xnor, 39)  \
  // X(_and, 40)   \
  // X(_nand, 40)  \
  // X(_or, 40)    \
  // X(_nor, 40)   \
  // X(_xor, 40)   \
  // X(_xnor, 40)  \
  // X(_and, 41)   \
  // X(_nand, 41)  \
  // X(_or, 41)    \
  // X(_nor, 41)   \
  // X(_xor, 41)   \
  // X(_xnor, 41)  \
  // X(_and, 42)   \
  // X(_nand, 42)  \
  // X(_or, 42)    \
  // X(_nor, 42)   \
  // X(_xor, 42)   \
  // X(_xnor, 42)  \
  // X(_and, 43)   \
  // X(_nand, 43)  \
  // X(_or, 43)    \
  // X(_nor, 43)   \
  // X(_xor, 43)   \
  // X(_xnor, 43)  \
  // X(_and, 44)   \
  // X(_nand, 44)  \
  // X(_or, 44)    \
  // X(_nor, 44)   \
  // X(_xor, 44)   \
  // X(_xnor, 44)  \
  // X(_and, 45)   \
  // X(_nand, 45)  \
  // X(_or, 45)    \
  // X(_nor, 45)   \
  // X(_xor, 45)   \
  // X(_xnor, 45)  \
  // X(_and, 46)   \
  // X(_nand, 46)  \
  // X(_or, 46)    \
  // X(_nor, 46)   \
  // X(_xor, 46)   \
  // X(_xnor, 46)  \
  // X(_and, 47)   \
  // X(_nand, 47)  \
  // X(_or, 47)    \
  // X(_nor, 47)   \
  // X(_xor, 47)   \
  // X(_xnor, 47)  \
  // X(_and, 48)   \
  // X(_nand, 48)  \
  // X(_or, 48)    \
  // X(_nor, 48)   \
  // X(_xor, 48)   \
  // X(_xnor, 48)  \
  // X(_and, 49)   \
  // X(_nand, 49)  \
  // X(_or, 49)    \
  // X(_nor, 49)   \
  // X(_xor, 49)   \
  // X(_xnor, 49)  \
  // X(_and, 50)   \
  // X(_nand, 50)  \
  // X(_or, 50)    \
  // X(_nor, 50)   \
  // X(_xor, 50)   \
  // X(_xnor, 50)  \
  // X(_and, 51)   \
  // X(_nand, 51)  \
  // X(_or, 51)    \
  // X(_nor, 51)   \
  // X(_xor, 51)   \
  // X(_xnor, 51)  \
  // X(_and, 52)   \
  // X(_nand, 52)  \
  // X(_or, 52)    \
  // X(_nor, 52)   \
  // X(_xor, 52)   \
  // X(_xnor, 52)  \
  // X(_and, 53)   \
  // X(_nand, 53)  \
  // X(_or, 53)    \
  // X(_nor, 53)   \
  // X(_xor, 53)   \
  // X(_xnor, 53)  \
  // X(_and, 54)   \
  // X(_nand, 54)  \
  // X(_or, 54)    \
  // X(_nor, 54)   \
  // X(_xor, 54)   \
  // X(_xnor, 54)  \
  // X(_and, 55)   \
  // X(_nand, 55)  \
  // X(_or, 55)    \
  // X(_nor, 55)   \
  // X(_xor, 55)   \
  // X(_xnor, 55)  \
  // X(_and, 56)   \
  // X(_nand, 56)  \
  // X(_or, 56)    \
  // X(_nor, 56)   \
  // X(_xor, 56)   \
  // X(_xnor, 56)  \
  // X(_and, 57)   \
  // X(_nand, 57)  \
  // X(_or, 57)    \
  // X(_nor, 57)   \
  // X(_xor, 57)   \
  // X(_xnor, 57)  \
  // X(_and, 58)   \
  // X(_nand, 58)  \
  // X(_or, 58)    \
  // X(_nor, 58)   \
  // X(_xor, 58)   \
  // X(_xnor, 58)  \
  // X(_and, 59)   \
  // X(_nand, 59)  \
  // X(_or, 59)    \
  // X(_nor, 59)   \
  // X(_xor, 59)   \
  // X(_xnor, 59)  \
  // X(_and, 60)   \
  // X(_nand, 60)  \
  // X(_or, 60)    \
  // X(_nor, 60)   \
  // X(_xor, 60)   \
  // X(_xnor, 60)  \
  // X(_and, 61)   \
  // X(_nand, 61)  \
  // X(_or, 61)    \
  // X(_nor, 61)   \
  // X(_xor, 61)   \
  // X(_xnor, 61)  \
  // X(_and, 62)   \
  // X(_nand, 62)  \
  // X(_or, 62)    \
  // X(_nor, 62)   \
  // X(_xor, 62)   \
  // X(_xnor, 62)  \
  // X(_and, 63)   \
  // X(_nand, 63)  \
  // X(_or, 63)    \
  // X(_nor, 63)   \
  // X(_xor, 63)   \
  // X(_xnor, 63)  \
  // X(_and, 64)   \
  // X(_nand, 64)  \
  // X(_or, 64)    \
  // X(_nor, 64)   \
  // X(_xor, 64)   \
  // X(_xnor, 64)

#endif /* __COSIM_GATE_MACROS_H__ */
