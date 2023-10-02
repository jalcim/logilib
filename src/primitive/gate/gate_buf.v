`ifndef __GATE_BUF__
 `define __GATE_BUF__

 `include "src/primitive/parallel_gate/parallel_buf.v"

module gate_buf(out, in);
   parameter WIRE = 1;
   input  [WIRE-1:0] in;
   output [WIRE-1:0] out;

   parallel_buf #(.WIRE(WIRE)) parallel_buf_inst(out, in);
endmodule

`endif
