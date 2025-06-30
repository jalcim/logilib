`ifndef __SLT__
 `define __SLT__

module slt(i_datain_A, i_datain_B, o_out);
   parameter WIRE = 32;
   input [WIRE-1:0] i_datain_A, i_datain_B;
   output [WIRE-1:0] o_out;
   wire		     sign_A, sign_B;
   wire		     sign_eqal;

   wire [3:0]	     line;

   assign sign_A = i_datain_A[WIRE-1];
   assign sign_B = i_datain_B[WIRE-1];

   assign line[2] = i_datain_A[WIRE-2:0] > i_datain_B[WIRE-2:0];
   assign line[3] = i_datain_A[WIRE-2:0] < i_datain_B[WIRE-2:0];

   assign line[1] = sign_B ? line[2] : 1;
   assign line[0] = sign_B ? 0 : line[3];

   assign o_out[0] = sign_A ? line[1] : line[0];
   assign o_out[WIRE-1:1] = 0;
endmodule

`endif
