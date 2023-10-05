`ifndef __PARALLEL_NOR__
 `define __PARALLEL_NOR__

 `include "src/primitive/gate/serial_gate/serial_nor.v"

module parallel_nor(out, in);
   parameter WAY = 2;
   parameter WIRE = 2;

   localparam SIZE = WAY * WIRE;
   input  [SIZE-1 : 0] in;
   output [WIRE-1 : 0] out;

   serial_nor #(.WAY(WAY)) nor1(out[0], in[WAY-1:0]);
   if (WIRE > 1)
     parallel_nor #(.WAY(WAY), .WIRE(WIRE-1)) parallel_nor0(out[WIRE-1:1],
							    in[SIZE-1 : WAY]);
endmodule

`endif
