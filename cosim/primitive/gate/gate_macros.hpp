#pragma once

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
