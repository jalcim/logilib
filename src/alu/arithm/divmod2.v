`ifndef __DIVMOD2__
 `define __DIVMOD2__

module divmod2(in, div2, mod2);
   parameter WIRE = 8;

   input [WIRE-1:0] in;

   output [WIRE-1:0] div2;
   output 	     mod2;

   genvar 	     cpt;
   
   assign mod2 = in[0];
   assign div2[WIRE-1] = 0;

   generate
      for (cpt = 0 ; cpt < WIRE-1 ; cpt = cpt + 1)
	assign div2[cpt] = in[cpt+1];
   endgenerate
endmodule

`endif
