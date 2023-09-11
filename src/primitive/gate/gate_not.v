`ifndef __GATE_NOT__
 `define __GATE_NOT__

 `include "../../serial_gate/src/serial_not.v"

module gate_not(out, in);
   parameter SIZE = 1;
   input in;
   output out;

   if (SIZE == 2)
     not not_inst(out, in);
   else if (SIZE > 2)
     serial_not #(.SIZE(SIZE)) serial_not_inst(out, in);
endmodule

`endif
