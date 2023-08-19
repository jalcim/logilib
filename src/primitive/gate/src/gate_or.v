`ifndef __GATE_OR__
 `define __GATE_OR__

 `include "../../serial_gate/src/serial_or.v"

module gate_or(out, in);
   parameter SIZE = 2;
   input [1:0] in;
   output out;

   if (SIZE == 2)
     or or_inst(out, in[0], in[1]);
   else if (SIZE > 2)
     serial_or #(.SIZE(SIZE)) serial_or_inst(out, in);
endmodule

`endif
