`ifndef __SRA_SRL__
 `define __SRA_SRL__

module sra_srl(funct7, datain_A, datain_B, out);
   parameter WIRE = 32;
   input [WIRE-1:0] datain_A, datain_B;
   input	    funct7;
   output [WIRE-1:0] out;

   assign out = funct7 ?
		{1'b1, (datain_A[WIRE-2:0] >> datain_B[5:0])}
		:
		datain_A >> datain_B[5:0];
endmodule

`endif
