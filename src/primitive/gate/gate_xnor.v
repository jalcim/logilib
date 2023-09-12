`ifndef __GATE_XNOR__
 `define __GATE_XNOR__

 `include "src/primitive/parallel_gate/parallel_xnor.v"
 `include "src/primitive/serial_gate/serial_xnor.v"

module gate_xnor(out, in);
   parameter WAY = 1;
   parameter WIRE = 2;

   localparam SIZE = WAY * WIRE;

   input [SIZE-1:0] in;
   output [WAY-1:0] out;

   if (WAY > 1)
     parallel_xnor #(.WAY(WAY), .WIRE(WIRE)) parallel_xnor_inst(out, in);
   else
     serial_xnor #(.WIRE(WIRE)) serial_xnor_inst(out, in);
endmodule

`endif
