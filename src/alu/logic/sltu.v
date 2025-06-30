`ifndef __SLTU__
 `define __SLTU__

module sltu(i_datain_A, i_datain_B, o_out);
   parameter WIRE = 32;
   input [WIRE-1:0] i_datain_A, i_datain_B;
   output [WIRE-1:0] o_out;

   assign o_out[0] = i_datain_A < i_datain_B;
   assign o_out[WIRE-1:1] = 0;
endmodule

`endif
