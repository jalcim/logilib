`ifndef __DLATCH_RST__
 `define __DLATCH_RST__

 `include "src/memory/Dlatch/parallel_Dlatch/parallel_Dlatch_rst.v"
 `include "src/memory/Dlatch/serial_Dlatch/serial_Dlatch_rst.v"

module Dlatch_rst(D, clk, reset, Q, QN);
   parameter WAY = 1;
   parameter WIRE = 1;

   input [WAY -1: 0] clk, reset;
   input [(WAY * WIRE)-1 : 0] D;
   output [(WAY * WIRE)-1:0]  Q, QN;

   wire			      or_0_out, nand_0_out, nand_1_out, xor_0_out, and_0_out, nand_2_out, not_0_out, nand_3_out;

   if (WAY > 1)
        parallel_Dlatch_rst #(.WAY(WAY), .WIRE(WIRE)) parallel_Dlatch_rst_inst(D, clk, reset, Q, QN);
   else if (WIRE > 1)
        serial_Dlatch_rst #(.WIRE(WIRE)) inst0(a, clk, rst, s1, s2);
   else
     begin
	xor xor0(xor_0_out, D, reset);
	and and0(and_0_out, D, xor_0_out);
   
	nand nand1(nand_2_out, and_0_out, clk);
	not not0(not_0_out, and_0_out);
	nand nand2(nand_3_out, clk, not_0_out);

	or or0(or_0_out, nand_1_out, reset);
	nand nand3(nand_0_out, nand_2_out, or_0_out);   
	nand nand4(nand_1_out, nand_0_out, nand_3_out);


	buf buf0(Q, nand_0_out);
	buf buf1(QN, nand_1_out);
     end

endmodule

`endif
