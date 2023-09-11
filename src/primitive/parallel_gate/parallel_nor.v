`ifndef __PARALLEL_NOR__
 `define __PARALLEL_NOR__

 `include "src/primitive/serial_gate/serial_nor.v"

module parallel_nor(out, in);
   parameter WAY = 2;
   parameter WIRE = 2;

   localparam SIZE = WAY * WIRE;

   input  [SIZE-1 : 0] in;
   output [WAY-1 : 0] out;

   serial_nor nor1(out[0], in[WIRE-1:0]);
   if (WAY > 1)
     parallel_nor #(.WAY(WAY-1), .WIRE(WIRE)) parallel_nor0(out[WAY-1:1],
							    in[SIZE-1 : WIRE]);
endmodule

`endif
