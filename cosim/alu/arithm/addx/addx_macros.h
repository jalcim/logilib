#ifndef __COSIM_ADDX_MACROS_H__
#define __COSIM_ADDX_MACROS_H__
#include "addx_includes.h"

#define RES_TEXT(error) (error ? "fail" : "success")

#define X_ADDX \
  X(add, 1)    \
  X(addX, 1)   \
  X(addX, 2)   \
  X(addX, 3)   \
  X(addX, 4)   \
  X(addX, 8)   \
  X(addX, 16)  \
  X(addX, 32)

#endif /* __COSIM_ADDX_MACROS_H__ */
