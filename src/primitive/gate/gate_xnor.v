`ifndef __GATE_XNOR__
 `define __GATE_XNOR__

 `include "src/primitive/parallel_gate/parallel_xnor.v"
 `include "src/primitive/serial_gate/serial_xnor.v"
 `include "src/routing/shuffle.v"

module gate_xnor(out, in);
   parameter WAY = 2;
   parameter WIRE = 1;

   localparam SIZE = WAY * WIRE;

   input [SIZE-1:0] in;
   output [WIRE-1:0] out;

   if (WIRE > 1)
     begin
	wire [SIZE-1 : 0]  shuffle_out;

	shuffle       #(.WAY(WAY), .WIRE(WIRE)) shuffle_inst(shuffle_out, in);
	parallel_xnor #(.WAY(WAY), .WIRE(WIRE)) parallel_xnor_inst(out, shuffle_out);
     end
   else
     serial_xnor #(.WAY(WAY)) serial_xnor_inst  (out, in);
endmodule

`endif
