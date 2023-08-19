`ifndef __GATE_XNOR__
 `define __GATE_XNOR__

 `include "../../serial_gate/src/serial_xnor.v"

module gate_xnor(out, in);
   parameter SIZE = 2;
   input [1:0] in;
   output out;

   if (SIZE == 2)
     xnor xnor_inst(out, in[0], in[1]);
   else if (SIZE > 2)
     serial_xnor #(.SIZE(SIZE)) serial_xnor_inst(out, in);
endmodule

`endif
