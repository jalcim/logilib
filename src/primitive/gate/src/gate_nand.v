`ifndef __GATE_NAND__
 `define __GATE_NAND__

 `include "../../serial_gate/src/serial_nand.v"

module gate_nand(out, in);
   parameter SIZE = 2;
   input [1:0] in;
   output out;

   if (SIZE == 2)
     nand nand_inst(out, in[0], in[1]);
   else if (SIZE > 2)
     serial_nand #(.SIZE(SIZE)) serial_nand_inst(out, in);
endmodule

`endif
