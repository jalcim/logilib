`ifndef __PARALLEL_XOR__
 `define __PARALLEL_XOR__

 `include "../../serial_gate/src/serial_xor.v"

module parallel_xor(out, in);
   parameter WAY = 2;
   parameter WIRE = 2;

   localparam SIZE = WAY * WIRE;

   input  [SIZE-1 : 0] in;
   output [WAY-1 : 0] out;

   serial_xor xor1(out[0], in[WIRE-1:0]);
   if (WAY > 1)
     parallel_xor #(.WAY(WAY-1), .WIRE(WIRE)) parallel_xor0(out[WAY-1:1],
							    in[SIZE-1 : WIRE]);
endmodule

`endif
