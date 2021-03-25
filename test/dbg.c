#include <stdio.h>

int main()
{
  unsigned char a = 170, b = 60;
  
  printf ("a & b = %u\n", a & b);
  printf ("a ~& b = %u\n", (unsigned char) ~(a & b));
  printf ("a | b = %u\n", a | b);
  printf ("a ~| b = %u\n", (unsigned char) ~(a | b));
  printf ("a ^ b = %u\n", a ^ b);
  printf ("a ^& b = %u\n", (unsigned char)~(a ^ b));
}
