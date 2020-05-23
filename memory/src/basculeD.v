module basculeD (a, clk, s1, s2);
   input a, clk;
   wire [4:0] line;
   output s1, s2;
   
   gate_nand nand1(a, clk, line[0]);

   gate_not not1(a, line[1]);
   gate_nand nand2(line[1], clk, line[2]);

   gate_nand nand3(line[0], line[4], line[3]);
   gate_nand nand4(line[2], line[3], line[4]);

   buf buf1(s1, line[3]);
   buf buf2(s2, line[4]);
endmodule // basculeD

module Dflip_flop(a, clk, s1, s2);
   input a, clk;
   output s1, s2;
   wire [6:0] line;

   basculeD basc1(a, clk, line[0], line[1]);
   gate_not not1(clk, line[2]);

   gate_nand nand1(line[2], line[0], line[3]);
   gate_nand nand2(line[2], line[1], line[4]);

   gate_nand nand3(line[3], line[5], line[6]);
   gate_nand nand4(line[4], line[6], line[5]);

   buf buf1(s1, line[6]);
   buf buf1(s2, line[5]);   
endmodule // flip_flopD
