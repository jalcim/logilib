`ifndef __SHUFFLE__
 `define __SHUFFLE__

module shuffle(out, in);
   parameter WAY = 2;
   parameter WIRE = 8;

   input  [WAY*WIRE-1:0]	  in;
   output [WAY*WIRE-1:0]	  out;

   genvar			  i, j;

   generate
      for (i = 0 ; i < WAY ; i = i + 1)
	for (j = 0 ; j < WIRE ; j = j + 1)
	  assign out[j * WAY + i] = in[i * WIRE + j];
   endgenerate
endmodule

`endif
