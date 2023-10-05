`ifndef __PARALLEL_NAND__
 `define __PARALLEL_NAND__

 `include "src/primitive/gate/serial_gate/serial_nand.v"

module parallel_nand(out, in);
   parameter WAY = 2;
   parameter WIRE = 2;

   localparam SIZE = WAY * WIRE;
   input  [SIZE-1 : 0] in;
   output [WIRE-1 : 0] out;

   serial_nand #(.WAY(WAY)) nand1(out[0], in[WAY-1:0]);
   if (WIRE > 1)
     parallel_nand #(.WAY(WAY) , .WIRE(WIRE-1)) parallel_nand0(out[WIRE-1:1],
							       in[SIZE-1 : WAY]);
endmodule

`endif
