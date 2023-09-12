`ifndef __GATE_NAND__
 `define __GATE_NAND__

 `include "src/primitive/parallel_gate/parallel_nand.v"
 `include "src/primitive/serial_gate/serial_nand.v"

module gate_nand(out, in);
   parameter WAY = 1;
   parameter WIRE = 2;

   localparam SIZE = WAY * WIRE;

   input [SIZE-1:0] in;
   output [WAY-1:0] out;

   if (WAY > 1)
     parallel_nand #(.WAY(WAY), .WIRE(WIRE)) parallel_nand_inst(out, in);
   else
     serial_nand #(.WIRE(WIRE)) serial_nand_inst(out, in);
endmodule

`endif
