module mult_cell(A, B, C, div2, mod2);
   parameter SIZE = 8;

   input A, B, C;

   output [SIZE-1:0] div2;
   output mod2;

   wire line, ignored;

   addX #(.SIZE(SIZE)) inst_add(A, B, 0, line, ignored);
   divmod2 #(.SIZE(SIZE)) inst_divmod2(line, div2, mod2);
endmodule
