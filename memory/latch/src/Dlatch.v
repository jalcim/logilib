/*
module Dlatch (a, clk, reset, s1, s2);
   input a, clk, reset;
   /* verilator lint_off UNOPTFLAT *//*
   wire [7:0] line;
   output     s1, s2;

   gate_xor xor1(a, reset, line[5]);
   gate_and and1(a, line[5], line[6]);

   gate_nand nand1(line[6], clk, line[0]);
   gate_not not1(line[6], line[1]);
   gate_nand nand2(line[1], clk, line[2]);

   gate_nand nand3(line[0], line[7], line[3]);
   gate_nand nand4(line[2], line[3], line[4]);

   gate_or or1(reset, line[4], line[7]);

   gate_buf buf1(line[3], s1);
   gate_buf buf2(line[4], s2);

endmodule
*/

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

   gate_xor xor1(a, reset, line5);
   gate_and and1(a, line5, line6);
   
   gate_nand nand1(line6, clk, line0);
   gate_not not1(line6, line1);
   gate_nand nand2(line1, clk, line2);

   gate_nand nand3(line0, line7, line3);
   gate_nand nand4(line2, line3, line4);

   gate_or or1(reset, line4, line7);
   
   gate_buf buf1(line3, s1);
   gate_buf buf2(line4, s2);
endmodule

