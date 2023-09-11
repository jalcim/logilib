`ifndef __GATE_OR__
 `define __GATE_OR__

 `include "src/parallel_gate/parallel_or.v"
 `include "src/serial_gate/serial_or.v"

module gate_or(out, in);
   parameter WAY = 1;
   parameter WIRE = 2;

   localparam SIZE = WAY * WIRE;

   input [SIZE-1:0] in;
   output out;

   if (WAY > 1)
     parallel_or #(.WAY(WAY), .WIRE(WIRE)) parallel_or_inst(out, in);
   else
     serial_or #(.WIRE(WIRE)) serial_or_inst(out, in);
endmodule

`endif
