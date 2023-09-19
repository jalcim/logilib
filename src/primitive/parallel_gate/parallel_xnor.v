`ifndef __PARALLEL_XNOR__
 `define __PARALLEL_XNOR__

 `include "src/primitive/serial_gate/serial_xnor.v"

module parallel_xnor(out, in);
   parameter WAY = 2;
   parameter WIRE = 2;

   localparam SIZE = WAY * WIRE;
   input  [SIZE-1 : 0] in;
   output [WIRE-1 : 0] out;

   serial_xnor #(.WAY(WAY)) xnor1(out[0], in[WAY-1:0]);
   if (WIRE > 1)
     parallel_xnor #(.WAY(WAY), .WIRE(WIRE-1)) parallel_xnor0(out[WIRE-1:1],
							      in[SIZE-1 : WAY]);
endmodule

`endif
