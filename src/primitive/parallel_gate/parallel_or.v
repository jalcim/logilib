`ifndef __PARALLEL_OR__
 `define __PARALLEL_OR__

 `include "src/primitive/serial_gate/serial_or.v"

module parallel_or(out, in);
   parameter WAY = 2;
   parameter WIRE = 2;

   localparam SIZE = WAY * WIRE;

   input  [SIZE-1 : 0] in;
   output [WAY-1 : 0] out;

   serial_or #(.WIRE(WIRE)) or1(out[0], in[WIRE-1:0]);
   if (WAY > 1)
     parallel_or #(.WAY(WAY-1), .WIRE(WIRE)) parallel_or0(out[WAY-1:1],
							    in[SIZE-1 : WIRE]);
endmodule

`endif
