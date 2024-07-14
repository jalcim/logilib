`ifndef __BIN_TO_DEC__
 `define __BIN_TO_DEC__
 `include "src/primitive/gate/gate_or.v"

module encoder(addr, in);
   parameter WAY = 4;
   localparam SIZE = 2**WAY;
   localparam WIRE = SIZE/2;

   input [SIZE-1:0] in;
   output [WAY-1:0] addr;
   wire [(WAY*WIRE)-1:0] converged;

   batch #(.WAY(WAY)) batch0(converged, in);

   gate_or #(.WAY(WIRE), .WIRE(1))
   or0(addr[0], converged[1*WIRE-1:0*WIRE]);

   gate_or #(.WAY(WIRE), .WIRE(1))
   or1(addr[1], converged[2*WIRE-1:1*WIRE]);

   gate_or #(.WAY(WIRE), .WIRE(1))
   or2(addr[2], converged[3*WIRE-1:2*WIRE]);

   gate_or #(.WAY(WIRE), .WIRE(1))
   or3(addr[3], converged[4*WIRE-1:3*WIRE]);
endmodule

module batch(out, in);
   parameter WAY = 4;
   localparam SIZE = 2**WAY;
   localparam WIRE = SIZE/2;

   parameter INDICE = 0;
   parameter SIZE_COUNTER = 0;
   parameter COUNTER = 0;
   localparam MASK = 1 << INDICE;
   localparam OFFSET = (INDICE * WIRE) + COUNTER;

   input [SIZE-1:0] in;
   output [(WAY*WIRE)-1:0] out;

   if (SIZE_COUNTER < SIZE)
     begin
	if (SIZE_COUNTER & MASK)
	  begin
	     assign out[OFFSET] = in[SIZE_COUNTER];
	     batch #(.WAY(WAY),
		     .SIZE_COUNTER(SIZE_COUNTER+1),
		     .INDICE(INDICE),
		     .COUNTER(COUNTER+1)) inst (out, in);
	  end
	else
	  batch #(.WAY(WAY),
		  .SIZE_COUNTER(SIZE_COUNTER+1),
		  .INDICE(INDICE),
		  .COUNTER(COUNTER)) inst (out, in);
     end

   if (INDICE < (WAY-1) && SIZE_COUNTER == 0)
     batch #(.WAY(WAY),
	     .SIZE_COUNTER(0),
	     .INDICE(INDICE+1),
	     .COUNTER(0)) inst (out, in);

endmodule

`endif
