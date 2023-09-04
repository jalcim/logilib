`ifndef __GATE_AND__
 `define __GATE_AND__

 `include "../../serial_gate/src/serial_and.v"

module gate_and(out, in);
   parameter WAY = 1;
   parameter WIRE = 2;

   localparam SIZE = WAY * WIRE;

   input [SIZE-1:0] in;
   output out;

   if (WAY == 1 && WIRE == 2)
     and and_inst(out, in[0], in[1]);
   else if (WAY > 1)
     parallel_and #(.WAY(WAY), .WIRE(WIRE)) parallel_and_inst(out, in);
   else if (WIRE > 2)
     serial_and #(.WIRE(WIRE)) serial_and_inst(out, in);
endmodule

`endif
