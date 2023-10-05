`ifndef __PARALLEL_OR__
 `define __PARALLEL_OR__

 `include "src/primitive/serial_gate/serial_or.v"

module parallel_or(out, in);
   parameter WAY = 2;
   parameter WIRE = 2;

   localparam SIZE = WAY * WIRE;
   input  [SIZE-1 : 0] in;
   output [WIRE-1 : 0] out;

   serial_or #(.WAY(WAY)) or1(out[0], in[WAY-1:0]);
   if (WIRE > 1)
     parallel_or #(.WAY(WAY), .WIRE(WIRE-1)) parallel_or0(out[WIRE-1:1],
							  in[SIZE-1 : WAY]);
endmodule

`endif
