`ifndef __DEMUX__
 `define __DEMUX__

module demux(ctrl, in, out);
   parameter WAY = 8;   // Nombre de voies par défaut
   parameter WIRE = 1;  // Taille des sorties

   `include "src/routing/log2.vh"

   localparam SIZE_CTRL = log2(WAY);
   localparam SIZE_OUT  = WAY * WIRE;//8*1

   input  [WIRE-1:0] in;
   input  [SIZE_CTRL-1:0] ctrl;
   output [SIZE_OUT-1:0] out;

   supply0 padding;

   if (SIZE_CTRL == 1)
     assign out = ctrl ? {in, {WIRE{padding}}} : {{WIRE{padding}}, in};
   else
     begin
        localparam N1 = (SIZE_OUT / 2) + (SIZE_OUT % 2);
        localparam N2 = SIZE_OUT / 2;

        wire [N1-1:0] W1;
        wire [N2-1:0] W2;

        assign out = ctrl[SIZE_CTRL-1] ? {W1, {N2{padding}}} : {{N1{padding}}, W2};
        demux #(.WAY(WAY/2), .WIRE(WIRE)) demux1(ctrl[SIZE_CTRL-2:0], in, W1);
        demux #(.WAY(WAY/2), .WIRE(WIRE)) demux2(ctrl[SIZE_CTRL-2:0], in, W2);
     end
endmodule

`endif
