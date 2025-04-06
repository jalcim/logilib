`ifndef __SERIAL_NAND__
 `define __SERIAL_NAND__

 `include "src/primitive/gate/serial/serial_and.v"

module serial_nand(out, e1);
   parameter WAY = 2;

   input [WAY-1:0] e1;
   output 	    out;

   wire		    line;
   serial_and #(.WAY(WAY)) serial_and_inst(line, e1);
   not inst_not0(out, line);
endmodule

`endif
