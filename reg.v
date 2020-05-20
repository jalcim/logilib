module basculeD (a, clk, s1, s2);
   input a;
   wire line[4:0];
   output s1, s2;
   
   nand nand1(a, clk, line[0]);

   not not2(a, line[1]);
   nand nand3(line[1], clk, line[2]);

   nand nand4(line[0], line[4], s1);
   nand nand5(line[2], line[3], s2);
endmodule; // basculeD

module flip_flopD(a, clk, s);
   input a, clk;
   output s1, s2;
   wire line[6:0];

   basculeD(a, clk, line[0], line[1]);
   not not1(clk, line[2]);

   nand nand1(line[2], line[0], line[3]);
   nand nand1(line[2], line[1], line[4]);

   nand nand1(line[3], line[5], s1);
   nand nand1(line[4], line[6], s2);
endmodule; // flip_flopD

