`ifndef __DLATCH_RST__
 `define __DLATCH_RST__

module Dlatch_rst(a, clk, reset, s1, s2);
   output s1,  s2;
   input  a, clk, reset;

   wire   or_0_out, nand_0_out, nand_1_out, xor_0_out, and_0_out, nand_2_out, not_0_out, nand_3_out;

   xor xor0(xor_0_out, a, reset);
   and and0(and_0_out, a, xor_0_out);
   
   nand nand2(nand_2_out, and_0_out, clk);
   not not0(not_0_out, and_0_out);
   nand nand3(nand_3_out, clk, not_0_out);

   nand nand0(nand_0_out, nand_2_out, or_0_out);   
   nand nand1(nand_1_out, nand_0_out, nand_3_out);

   or or0(or_0_out, nand_1_out, reset);

   buf buf0(s1, nand_0_out);
   buf buf1(s2, nand_1_out);

endmodule

`endif
