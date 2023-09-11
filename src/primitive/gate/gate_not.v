`ifndef __GATE_NOT__
 `define __GATE_NOT__

 `include "src/primitive/parallel_gate/parallel_not.v"
 `include "src/primitive/serial_gate/serial_not.v"

module gate_not(out, in);
   parameter WAY = 1;
   parameter WIRE = 1;
   input in;
   output [WIRE-1:0] out;

   if (WAY > 1)
     parallel_not #(.WAY(WAY), .WIRE(WIRE)) parallel_not_inst(out, in);
   else
     serial_not #(.WIRE(WIRE)) serial_not_inst(out, in);
endmodule

`endif
