`ifndef __GATE_NOR__
 `define __GATE_NOR__

 `include "src/primitive/parallel_gate/parallel_nor.v"
 `include "src/primitive/serial_gate/serial_nor.v"
 `include "src/routing/shuffle.v"

module gate_nor(out, in);
   parameter BEHAVIORAL = 1;
   parameter WAY = 2;
   parameter WIRE = 1;

   localparam SIZE = WAY * WIRE;
   input [SIZE-1:0] in;
   output [WIRE-1:0] out;

   if (WIRE > 1)
     begin
	wire [SIZE-1 : 0]  shuffle_out;
	shuffle      #(                         .WAY(WAY), .WIRE(WIRE)) shuffle_inst(shuffle_out, in);
	parallel_nor #(.BEHAVIORAL(BEHAVIORAL), .WAY(WAY), .WIRE(WIRE)) parallel_nor_inst(out, shuffle_out);
     end
   else
     serial_nor   #(.BEHAVIORAL(BEHAVIORAL), .WAY(WAY)) serial_nor_inst  (out, in);
endmodule

`endif
