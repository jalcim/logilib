#include "stdio.h"

int dump(void *myStruct, long size)
{
  unsigned int i;
  const unsigned char *const px = (unsigned char *)myStruct;
  for (i = 0; i < size; ++i)
  {
    if (i % (sizeof(int) * 8) == 0)
    {
      printf("\n%08X ", i);
    }
    else if (i % 4 == 0)
    {
      printf(" ");
    }
    printf("%02X", px[i]);
  }

  printf("\n\n");
  return 0;
}
