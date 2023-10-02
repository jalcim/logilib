`ifndef __SLT__
 `define __SLT__

module slt(datain_A, datain_B, out);
   parameter WIRE = 32;
   input [WIRE-1:0] datain_A, datain_B;
   output [WIRE-1:0] out;
   wire		     sign_A, sign_B;
   wire		     sign_eqal;

   wire [3:0]	     line;

   assign sign_A = datain_A[WIRE-1];
   assign sign_B = datain_B[WIRE-1];

   assign line[2] = datain_A[WIRE-2:0] > datain_B[WIRE-2:0];
   assign line[3] = datain_A[WIRE-2:0] < datain_B[WIRE-2:0];

   assign line[1] = sign_B ? line[2] : 1;
   assign line[0] = sign_B ? 0 : line[3];

   assign out = sign_A ? line[1] : line[0];

endmodule

`endif
