`ifndef __SRA_SRL__
 `define __SRA_SRL__

module sra_srl(i_funct7, i_datain_A, i_datain_B, o_out);
   parameter WIRE = 32;
   input [WIRE-1:0] i_datain_A, i_datain_B;
   input [6:0]	    i_funct7;
   output [WIRE-1:0] o_out;

   assign o_out = i_funct7[6] ?
		  {i_datain_A[WIRE-1], (i_datain_A[WIRE-2:0] >> i_datain_B[5:0])}
		  :
		  i_datain_A >> i_datain_B[5:0];
endmodule

`endif
