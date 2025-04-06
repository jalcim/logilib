`ifndef __BIN_TO_DEC__
 `define __BIN_TO_DEC__
 `include "src/primitive/gate/multi/multi_or.v"

module encoder(addr, in);
   parameter SIZE_ADDR = 4;
   localparam SIZE = 2**SIZE_ADDR;
   localparam WAY = SIZE/2;

   input [SIZE-1:0] in;
   output [SIZE_ADDR-1:0] addr;
   wire [(SIZE_ADDR*WAY)-1:0] converged;

   batch #(.WAY(SIZE_ADDR)) batch0(converged, in);
   multi_or #(.NB_GATE(SIZE_ADDR), .WAY(WAY), .WIRE(1))
   initial_multi_or(addr, converged);
   
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
