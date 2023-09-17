`ifndef __GATE_NAND__
 `define __GATE_NAND__

 `include "src/primitive/parallel_gate/parallel_nand.v"
 `include "src/primitive/serial_gate/serial_nand.v"
 `include "src/routing/shuffle.v"

module gate_nand(out, in);
   parameter BEHAVIORAL = 0;
   parameter WAY = 1;
   parameter WIRE = 2;

   localparam SIZE = WAY * WIRE;

   input [SIZE-1:0] in;
   output [WAY-1:0] out;

   if (WAY > 1)
     begin
	wire [SIZE-1 : 0]  shuffle_out;

	shuffle #(.WAY(WAY), .WIRE(WIRE)) shuffle_inst(shuffle_out, in);
	parallel_nand #(.BEHAVIORAL(BEHAVIORAL), .WAY(WAY), .WIRE(WIRE)) parallel_nand_inst(out, shuffle_out);
     end
   else
     serial_nand   #(.BEHAVIORAL(BEHAVIORAL),            .WIRE(WIRE)) serial_nand_inst  (out, in);
endmodule

`endif
