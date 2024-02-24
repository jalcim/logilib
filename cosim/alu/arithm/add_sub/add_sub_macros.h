#ifndef __COSIM_ADD_SUB_MACROS_H__
#define __COSIM_ADD_SUB_MACROS_H__
#include "add_sub_includes.h"

#define RES_TEXT(error) (error ? "fail" : "success")

#define X_ADD_SUB \
  X(add_sub, 1)   \
  X(add_sub, 2)   \
  X(add_sub, 3)   \
  X(add_sub, 4)   \
  X(add_sub, 8)   \
  X(add_sub, 16)  \
  X(add_sub, 32)

#endif /* __COSIM_ADD_SUB_MACROS_H__ */
