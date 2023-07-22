#include <stdio.h>

int main()
{
  unsigned char a;

  char b, c;

  b = 0;
  c = 12;
  a = (unsigned char)b - c;
  printf("%u\n", a);
}
