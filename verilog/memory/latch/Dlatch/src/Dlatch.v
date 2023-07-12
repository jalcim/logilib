module Dlatch (a, clk, reset, s1, s2);
   input a, clk, reset;
   output s1, s2;

   wire   line0;
   wire   line1;
   wire   line2;
   wire   line3;
 /* verilator lint_off UNOPTFLAT */
   wire   line4;//DIDNOTCONVERGE
   wire   line5;
   wire   line6;
   wire   line7;

   xor xor1(line5, a, reset);
   and and1(line6, a, line5);
   
   nand nand1(line0, line6, clk);
   not not1(line1, line6);
   nand nand2(line2, line1, clk);

   nand nand3(line3, line0, line7);
   nand nand4(line4, line2, line3);

   or or1(line7, reset, line4);

   buf buf1(s1, line3);
   buf buf2(s2, line4);
endmodule
