`ifndef __MUX__
 `define __MUX__

module mux(ctrl, in, out);
   parameter WAY = 8;  // Nombre de voies par défaut
   parameter WIRE = 1;

   `include "src/routing/log2.vh"
   localparam SIZE_CTRL = log2(WAY);
   localparam SIZE_IN = WAY * WIRE;

   input [SIZE_IN - 1:0] in;
   input [SIZE_CTRL-1:0]	 ctrl;

   output [WIRE-1:0]	 out;

   if (SIZE_CTRL == 1)
     assign out = ctrl ? in[2 * WIRE - 1 : WIRE] : in[WIRE - 1 : 0];
   else
     begin
	wire [WIRE-1:0]out1, out2;

	assign out = ctrl[SIZE_CTRL - 1] ? out2 : out1;
	mux #(.WAY(WAY/2), .WIRE(WIRE)) mux1(.ctrl(ctrl[SIZE_CTRL - 2:0]),
					     .in(in[(WAY/2) * WIRE - 1:0]),
					     .out(out1));

	mux #(.WAY(WAY/2), .WIRE(WIRE)) mux2(.ctrl(ctrl[SIZE_CTRL - 2:0]),
					     .in(in[SIZE_IN - 1 : (WAY/2) * WIRE]),
                                             .out(out2));

     end
endmodule

`endif
