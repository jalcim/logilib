`ifndef __PARALLEL_AND__
 `define __PARALLEL_AND__

 `include "src/primitive/serial_gate/serial_and.v"

module parallel_and(out, in);
   parameter WAY = 2;
   parameter WIRE = 2;

   localparam SIZE = WAY * WIRE;
   input  [SIZE-1 : 0] in;
   output [WIRE-1 : 0] out;

   serial_and #(.WAY(WAY)) and1(out[0], in[WAY-1:0]);
   if (WIRE > 1)
     parallel_and #(.WAY(WAY), .WIRE(WIRE-1)) parallel_and0(out[WIRE-1:1],
							    in[SIZE-1 : WAY]);
endmodule

`endif
