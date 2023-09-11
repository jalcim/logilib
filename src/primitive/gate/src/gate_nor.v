`ifndef __GATE_NOR__
 `define __GATE_NOR__

 `include "../../parallel_gate/src/parallel_nor.v"
 `include "../../serial_gate/src/serial_nor.v"

module gate_nor(out, in);
   parameter WAY = 1;
   parameter WIRE = 2;

   localparam SIZE = WAY * WIRE;

   input [SIZE-1:0] in;
   output out;

   if (WAY > 1)
     parallel_nor #(.WAY(WAY), .WIRE(WIRE)) parallel_nor_inst(out, in);
   else
     serial_nor #(.WIRE(WIRE)) serial_nor_inst(out, in);
endmodule

`endif
