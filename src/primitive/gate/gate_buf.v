`ifndef __GATE_BUF__
 `define __GATE_BUF__

 `include "src/primitive/parallel_gate/parallel_buf.v"

module gate_buf(out, in);
   parameter WAY = 1;
   input  [WAY-1:0] in;
   output [WAY-1:0] out;

   parallel_buf #(.WAY(WAY)) parallel_buf_inst(out, in);
endmodule

`endif
