module basculeD (a, clk, s1, s2);
   input a;
   wire [4:0] line;
   output s1, s2;
   
   nand nand1(a, clk, line[0]);

   not not1(a, line[1]);
   nand nand2(line[1], clk, line[2]);

   nand nand3(line[0], line[4], s1);
   nand nand4(line[2], line[3], s2);
endmodule; // basculeD

module flip_flopD(a, clk, s);
   input a, clk;
   output s1, s2;
   wire [6:0] line;

   basculeD(a, clk, line[0], line[1]);
   not not1(clk, line[2]);

   nand nand1(line[2], line[0], line[3]);
   nand nand2(line[2], line[1], line[4]);

   nand nand3(line[3], line[5], s1);
   nand nand4(line[4], line[6], s2);
endmodule; // flip_flopD

