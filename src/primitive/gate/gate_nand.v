`ifndef __GATE_NAND__
 `define __GATE_NAND__

 `include "src/primitive/parallel_gate/parallel_nand.v"
 `include "src/primitive/serial_gate/serial_nand.v"
 `include "src/routing/shuffle.v"

module gate_nand(out, in);
   parameter BEHAVIORAL = 1;
   parameter WAY = 2;//nombre d'input
   parameter WIRE = 1;//nombre de fil par input

   localparam SIZE = WAY * WIRE;
   input [SIZE-1:0] in;
   output [WIRE-1:0] out;//1 output par WIRE

   if (WIRE > 1)//le nombre de WIRE par input indique combien de portes sont en parallele
     begin
	wire [SIZE-1 : 0]  shuffle_out;
	shuffle       #(                         .WAY(WAY), .WIRE(WIRE)) shuffle_inst(shuffle_out, in);
	parallel_nand #(.BEHAVIORAL(BEHAVIORAL), .WAY(WAY), .WIRE(WIRE)) parallel_nand_inst(out, shuffle_out);
     end
   else//le nombre d'input (WAY) indique combien d'input la gate doit avoir
     serial_nand #(.BEHAVIORAL(BEHAVIORAL), .WAY(WAY)) serial_nand_inst  (out, in);
endmodule

`endif
