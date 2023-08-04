module mult_cell(A, B, C, div2, mod2);
   parameter SIZE = 8;

   input A, B, C;

   output [SIZE-1:0] div2;
   output mod2;

   wire line, ignored;
   wire [SIZE-1:0]   sub_repliq;
   wire [SIZE-1:0]   b_line;

   serial_buf #(.SIZE(SIZE)) replicator(A_repliq, A);
   parallel_and #(.SIZE(SIZE)) mux(b_line, B, A_repliq);
   addX #(.SIZE(SIZE)) inst_add(B, C, 0, line, ignored);
   divmod2 #(.SIZE(SIZE)) inst_divmod2(line, div2, mod2);
endmodule
