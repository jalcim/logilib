`ifndef __PARALLEL_XOR__
 `define __PARALLEL_XOR__

 `include "src/primitive/serial_gate/serial_xor.v"

module parallel_xor(out, in);
   parameter WAY = 2;
   parameter WIRE = 2;

   localparam SIZE = WAY * WIRE;

   input  [SIZE-1 : 0] in;
   output [WIRE-1 : 0] out;

   serial_xor #(.WAY(WAY)) xor1(out[0], in[WAY-1:0]);
   if (WIRE > 1)
     parallel_xor #(.WAY(WAY), .WIRE(WIRE-1)) parallel_xor0(out[WIRE-1:1],
							    in[SIZE-1 : WAY]);
endmodule

`endif
