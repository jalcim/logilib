`ifndef __SLL__
 `define __SLL__

module sll(i_datain_A, i_datain_B, o_out);
   parameter WIRE = 32;
   input [WIRE-1:0] i_datain_A, i_datain_B;
   output [WIRE-1:0] o_out;

   assign o_out = i_datain_A << i_datain_B[5:0];
endmodule

`endif
