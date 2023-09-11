`ifndef __PARALLEL_NAND__
 `define __PARALLEL_NAND__

 `include "src/primitive/serial_gate/serial_nand.v"

module parallel_nand(out, in);
   parameter WAY = 2;
   parameter WIRE = 2;

   localparam SIZE = WAY * WIRE;

   input  [SIZE-1 : 0] in;
   output [WAY-1 : 0] out;

   serial_nand nand1(out[0], in[WIRE-1:0]);
   if (WAY > 1)
     parallel_nand #(.WAY(WAY-1), .WIRE(WIRE)) parallel_nand0(out[WAY-1:1],
							    in[SIZE-1 : WIRE]);
endmodule

`endif
