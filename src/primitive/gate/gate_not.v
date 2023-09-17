`ifndef __GATE_NOT__
 `define __GATE_NOT__

 `include "src/primitive/parallel_gate/parallel_not.v"

module gate_not(out, in);
   parameter WAY = 1;
   input  [WAY-1:0] in;
   output [WAY-1:0] out;

     parallel_not #(.WAY(WAY)) parallel_not_inst(out, in);
endmodule

`endif
