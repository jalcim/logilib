module basculeD (a, clk, reset, s1, s2);
   input a, clk, reset;
   wire [7:0] line;
   output s1, s2;

   gate_xor xor1(a, reset, line[5]);
   gate_and and1(a, line[5], line[6]);

   gate_nand nand1(a, clk, line[0]);
   gate_not not1(line[6], line[1]);
   gate_nand nand2(line[1], clk, line[2]);

   gate_nand nand3(line[0], line[7], line[3]);
   gate_nand nand4(line[2], line[3], line[4]);

   gate_or or1(reset, line[4], line[7]);
   
   buf buf1(s1, line[3]);
   buf buf2(s2, line[4]);
endmodule // basculeD

module Dflip_flop(a, clk, reset, s1, s2);
   input a, clk, reset;
   output s1, s2;
   wire [3:0] line;
   wire       ignore;
   
   basculeD basc1(a, clk, reset, line[0], ignore);
   gate_not not1(clk, line[1]);
   basculeD basc2(line[0], line[1], reset, line[2], line[3]);

   buf buf1(s1, line[2]);
   buf buf1(s2, line[3]);   
endmodule // flip_flopD
