unsigned int test_bru(unsigned int in,
		      unsigned int funct3,
		      unsigned int SIGNAL_bru)
{
  unsigned int beq = in == 0;
  unsigned int bne = in != 0;
  unsigned int blt = in & (1 << 31) == 1;
  unsigned int bge = !(in & (1 << 31)) && in;

  unsigned int out_bru = funct3 & 4 ?
    funct3 & 1 ? bge : blt
    :
    funct3 & 1 ? bne : beq;

  unsigned int SIGNAL_pc = SIGNAL_bru & out_bru;


  return (SIGNAL_pc);
}
