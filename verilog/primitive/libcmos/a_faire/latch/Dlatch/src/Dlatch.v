module Dlatch (a, clk, reset, s1, s2);
   input a, clk, reset;
   wire [7:0] line;
   output s1, s2;

   xor xor1(line[5], a, reset);
   and and1(line[6], a, line[5]);

   nand nand1(line[0], line[6], clk);
   not not1(line[1], line[6]);
   nand nand2(line[2], line[1], clk);

   nand nand3(line[3], line[0], line[7]);
   nand nand4(line[4], line[2], line[3]);

   or or1(line[7], reset, line[4]);
   
   buf buf1(s1, line[3]);
   buf buf2(s2, line[4]);
endmodule // basculeD
