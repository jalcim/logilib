`ifndef __DEMUX__
 `define __DEMUX__

module demux(ctrl, in, out);
   parameter WAY = 2;//nombre de sortie = 2^WAY
   parameter WIRE = 1;//taille des sorties

   localparam	  NB_OUT = 2 ** WAY;
   localparam	  SIZE_OUT = NB_OUT * WIRE;

   input [WIRE-1:0] in;
   input [WAY-1:0]  ctrl;

   output [SIZE_OUT - 1:0] out;

   supply0		   padding;

   if (WAY == 1)
     assign out = ctrl ? {in, {WIRE{padding}}} : {{WIRE{padding}}, in};
   else
     begin
	localparam	  N1 = (SIZE_OUT / 2) + (SIZE_OUT % 2);
	localparam	  N2 = SIZE_OUT / 2;

	wire [N1 - 1:0]	  W1;
	wire [N2 - 1:0]	  W2;

	assign out = ctrl[WAY-1] ? {W1, {N2{padding}}} : {{N1{padding}}, W2};
	demux #(.WAY(WAY-1), .WIRE(WIRE)) mux1(ctrl[WAY - 2:0], in, W1);
	demux #(.WAY(WAY-1), .WIRE(WIRE)) mux2(ctrl[WAY - 2:0], in, W2);
     end
endmodule

`endif
