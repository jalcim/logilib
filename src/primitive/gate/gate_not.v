`ifndef __GATE_NOT__
 `define __GATE_NOT__

 `include "src/primitive/parallel_gate/parallel_not.v"

module gate_not(out, in);
   parameter WIRE = 1;
   input  [WIRE-1:0] in;
   output [WIRE-1:0] out;

     parallel_not #(.WIRE(WIRE)) parallel_not_inst(out, in);
endmodule

`endif
