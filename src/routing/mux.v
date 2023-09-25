`ifndef __MUX__
 `define __MUX__

module mux(ctrl, in, out);
   parameter SIZE_CTRL = 1;//nombre de sortie = 2^SIZE_CTRL
   parameter WIRE = 8;//taille des sorties

   localparam	  WAY = 2 ** SIZE_CTRL;
   localparam	  SIZE_IN = WAY * WIRE;

   input [SIZE_IN - 1:0] in;
   input [SIZE_CTRL-1:0]	 ctrl;

   output [WIRE-1:0]	 out;

   if (SIZE_CTRL == 1)
     assign out = ctrl ? in[2 * WIRE - 1 : WIRE] : in[WIRE - 1 : 0];
   else
     begin
	wire [WIRE-1:0]out1, out2;

	assign out = ctrl[SIZE_CTRL - 1] ? out2 : out1;
	mux #(.SIZE_CTRL(SIZE_CTRL - 1), .WIRE(WIRE)) mux1(.ctrl(ctrl[SIZE_CTRL - 2:0]),
					       .in(in[(2 ** (SIZE_CTRL - 1)) * WIRE - 1:0]),
					       .out(out1));

	mux #(.SIZE_CTRL(SIZE_CTRL - 1), .WIRE(WIRE)) mux2(.ctrl(ctrl[SIZE_CTRL - 2:0]),
					       .in(in[(2 ** SIZE_CTRL) * WIRE - 1:(2 ** (SIZE_CTRL - 1)) * WIRE]),
					       .out(out2));
     end
endmodule

`endif
