`ifndef __PARALLEL_AND__
 `define __PARALLEL_AND__

 `include "../../serial_gate/src/serial_and.v"

module parallel_and(out, in);
   parameter WAY = 2;
   parameter WIRE = 2;

   localparam SIZE = WAY * WIRE;

   input  [SIZE-1 : 0] in;
   output [WAY-1 : 0] out;

   serial_and and1(out[0], in[WIRE-1:0]);
   if (WAY > 1)
     parallel_and #(.WAY(WAY-1), .WIRE(WIRE)) parallel_and0(out[WAY-1:1],
							    in[SIZE-1 : WIRE]);
endmodule

`endif
