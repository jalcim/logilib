`ifndef __GATE_OR__
 `define __GATE_OR__

 `include "src/primitive/parallel_gate/parallel_or.v"
 `include "src/primitive/serial_gate/serial_or.v"
 `include "src/routing/shuffle.v"

module gate_or(out, in);
   parameter WAY = 2;
   parameter WIRE = 1;

   localparam SIZE = WAY * WIRE;

   input [SIZE-1:0] in;
   output [WIRE-1:0] out;

   if (WIRE > 1)
     begin
	wire [SIZE-1 : 0]  shuffle_out;
	shuffle     #(.WAY(WAY), .WIRE(WIRE)) shuffle_inst(shuffle_out, in);
	parallel_or #(.WAY(WAY), .WIRE(WIRE)) parallel_or_inst(out, shuffle_out);
     end
   else
     serial_or #(.WAY(WAY)) serial_or_inst(out, in);
endmodule

`endif
