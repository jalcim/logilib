`ifndef __SERIAL_NOR__
 `define __SERIAL_NOR__

 `include "src/primitive/gate/serial_gate/serial_or.v"

module serial_nor(out, e1);
   parameter WAY = 2;

   input [WAY-1:0] e1;
   output 	    out;

   wire		    line;
   serial_or #(.WAY(WAY)) serial_or_inst(line, e1);
   not inst_not0(out, line);
endmodule

`endif
