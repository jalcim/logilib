`ifndef __MUX__
 `define __MUX__

module mux(ctrl, in, out);
   parameter WAY = 1;//nombre de sortie = 2^WAY
   parameter WIRE = 8;//taille des sorties

   localparam	  NB_IN = 2 ** WAY;
   localparam	  SIZE_IN = NB_IN * WIRE;

   input [SIZE_IN - 1:0] in;
   input [WAY-1:0]	 ctrl;

   output [WIRE-1:0]	 out;

   if (WAY == 1)
     assign out = ctrl ? in[2 * WIRE - 1 : WIRE] : in[WIRE - 1 : 0];
   else
     begin
	wire [WIRE-1:0]out1, out2;

	assign out = ctrl[WAY - 1] ? out2 : out1;
	mux #(.WAY(WAY - 1), .WIRE(WIRE)) mux1(.ctrl(ctrl[WAY - 2:0]),
					       .in(in[(2 ** (WAY - 1)) * WIRE - 1:0]),
					       .out(out1));

	mux #(.WAY(WAY - 1), .WIRE(WIRE)) mux2(.ctrl(ctrl[WAY - 2:0]),
					       .in(in[(2 ** WAY) * WIRE - 1:(2 ** (WAY - 1)) * WIRE]),
					       .out(out2));
     end
endmodule

`endif
