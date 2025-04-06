`ifndef __SERIAL_XNOR__
 `define __SERIAL_XNOR__

 `include "src/primitive/gate/serial/serial_xor.v"

module serial_xnor(out, e1);
   parameter WAY = 3;//nombre d'input (pour cette gate)

   input [WAY-1:0] e1;
   output 	    out;

   wire		    line;
   serial_xor #(.WAY(WAY)) serial_and_inst(line, e1);
   not inst_not0(out, line);
endmodule

`endif
