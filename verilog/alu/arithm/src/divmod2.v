module divmod2(in, div2, mod2);
   parameter SIZE = 8;

   input [SIZE-1:0] in;

   output [SIZE-1:0] div2;
   output 	     mod2;

   genvar 	     cpt;
   
   assign mod2 = in[0];
   assign div2[SIZE-1] = 0;

   generate
      for (cpt = 0 ; cpt < SIZE-1 ; cpt = cpt + 1)
	assign div2[cpt] = in[cpt+1];
   endgenerate
endmodule
