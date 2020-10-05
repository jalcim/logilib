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

module basculeD_8bit(a, clk, reset, s1, s2);
   input [7:0]  a;
   input        clk, reset;
   output [7:0] s1, s2;

   basculeD Dlatch0(a[0], clk, reset, s1[0], s2[0]);
   basculeD Dlatch1(a[1], clk, reset, s1[1], s2[1]);
   basculeD Dlatch2(a[2], clk, reset, s1[2], s2[2]);
   basculeD Dlatch3(a[3], clk, reset, s1[3], s2[3]);
   basculeD Dlatch4(a[4], clk, reset, s1[4], s2[4]);
   basculeD Dlatch5(a[5], clk, reset, s1[5], s2[5]);
   basculeD Dlatch6(a[6], clk, reset, s1[6], s2[6]);
   basculeD Dlatch7(a[7], clk, reset, s1[7], s2[7]);
   
endmodule // basculeD_8bit

module Dflip_flop(a, clk, reset, s1, s2);
   input a, clk, reset;
   output s1, s2;
   wire [3:0] line;
   wire       ignore;
   
   basculeD basc1(a, clk, reset, line[0], ignore);
   gate_not not1(clk, line[1]);
   basculeD basc2(line[0], line[1], reset, line[2], line[3]);

   buf buf1(s1, line[2]);
   buf buf2(s2, line[3]);   
endmodule // flip_flopD

module Dflip_flop3(in, clk, reset, out1, out2);
   input [2:0] in;
   input       clk, reset;
   output [2:0] out1, out2;

   Dflip_flop Dff0(in[0], clk, reset, out1[0], out2[0]);
   Dflip_flop Dff1(in[1], clk, reset, out1[1], out2[1]);
   Dflip_flop Dff2(in[2], clk, reset, out1[2], out2[2]);
endmodule // flip_flopD
