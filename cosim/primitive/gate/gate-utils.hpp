#pragma once

constexpr unsigned long get_bit_bitmasks[33] = {
    0x00000000,  // [0]  (spécial)
    0x00000001,  // [1]  1<<0
    0x00000002,  // [2]  1<<1
    0x00000004,  // [3]  1<<2
    0x00000008,  // [4]  1<<3
    0x00000010,  // [5]  1<<4
    0x00000020,  // [6]  1<<5
    0x00000040,  // [7]  1<<6
    0x00000080,  // [8]  1<<7
    0x00000100,  // [9]  1<<8
    0x00000200,  // [10] 1<<9
    0x00000400,  // [11] 1<<10
    0x00000800,  // [12] 1<<11
    0x00001000,  // [13] 1<<12
    0x00002000,  // [14] 1<<13
    0x00004000,  // [15] 1<<14
    0x00008000,  // [16] 1<<15
    0x00010000,  // [17] 1<<16
    0x00020000,  // [18] 1<<17
    0x00040000,  // [19] 1<<18
    0x00080000,  // [20] 1<<19
    0x00100000,  // [21] 1<<20
    0x00200000,  // [22] 1<<21
    0x00400000,  // [23] 1<<22
    0x00800000,  // [24] 1<<23
    0x01000000,  // [25] 1<<24
    0x02000000,  // [26] 1<<25
    0x04000000,  // [27] 1<<26
    0x08000000,  // [28] 1<<27
    0x10000000,  // [29] 1<<28
    0x20000000,  // [30] 1<<29
    0x40000000,  // [31] 1<<30
    0x80000000   // [32] 1<<31 (dernier bit valide)
};

constexpr unsigned long get_n_bits_bitmasks[33] = {
    0x00000000,  // [0]  (1<<0)-1 (spécial)
    0x00000001,  // [1]  (1<<1)-1
    0x00000003,  // [2]  (1<<2)-1
    0x00000007,  // [3]  (1<<3)-1
    0x0000000F,  // [4]  (1<<4)-1
    0x0000001F,  // [5]  (1<<5)-1
    0x0000003F,  // [6]  (1<<6)-1
    0x0000007F,  // [7]  (1<<7)-1
    0x000000FF,  // [8]  (1<<8)-1
    0x000001FF,  // [9]  (1<<9)-1
    0x000003FF,  // [10] (1<<10)-1
    0x000007FF,  // [11] (1<<11)-1
    0x00000FFF,  // [12] (1<<12)-1
    0x00001FFF,  // [13] (1<<13)-1
    0x00003FFF,  // [14] (1<<14)-1
    0x00007FFF,  // [15] (1<<15)-1
    0x0000FFFF,  // [16] (1<<16)-1
    0x0001FFFF,  // [17] (1<<17)-1
    0x0003FFFF,  // [18] (1<<18)-1
    0x0007FFFF,  // [19] (1<<19)-1
    0x000FFFFF,  // [20] (1<<20)-1
    0x001FFFFF,  // [21] (1<<21)-1
    0x003FFFFF,  // [22] (1<<22)-1
    0x007FFFFF,  // [23] (1<<23)-1
    0x00FFFFFF,  // [24] (1<<24)-1
    0x01FFFFFF,  // [25] (1<<25)-1
    0x03FFFFFF,  // [26] (1<<26)-1
    0x07FFFFFF,  // [27] (1<<27)-1
    0x0FFFFFFF,  // [28] (1<<28)-1
    0x1FFFFFFF,  // [29] (1<<29)-1
    0x3FFFFFFF,  // [30] (1<<30)-1
    0x7FFFFFFF,  // [31] (1<<31)-1
    0xFFFFFFFF   // [32] (1<<32)-1 (tous bits à 1)
};

inline unsigned long TO_BIT(unsigned long integer)
{
  return (!(!integer));
}

inline unsigned long GET_BIT(unsigned long integer, unsigned long offset)
{
  return TO_BIT(integer & (1 << offset));
}
#include <stdio.h>
inline unsigned long GET_BIT_RANGE(unsigned long integer, unsigned size, unsigned offset)
{
  unsigned long out = integer & get_n_bits_bitmasks[size];
  //  return (integer & (get_n_bits_bitmasks[size] << offset)) >> offset;
  return (out);
}

inline unsigned long NEXT_INPUT(unsigned long input, unsigned next_way)
{
  return (input & get_n_bits_bitmasks[next_way]);
}

unsigned long test_buf (unsigned long input, unsigned way, unsigned wire);
unsigned long test_not (unsigned long input, unsigned way, unsigned wire);
unsigned long test_and (unsigned long input, unsigned way, unsigned wire);
unsigned long test_nand(unsigned long input, unsigned way, unsigned wire);
unsigned long test_or  (unsigned long input, unsigned way, unsigned wire);
unsigned long test_nor (unsigned long input, unsigned way, unsigned wire);
unsigned long test_xor (unsigned long input, unsigned way, unsigned wire);
unsigned long test_xnor(unsigned long input, unsigned way, unsigned wire);
