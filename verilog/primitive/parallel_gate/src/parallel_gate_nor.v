module parallel_nor(A, B, out);
   parameter S = 3;

   input  [S-1 : 0] A, B;
   output [S-1 : 0] out;

   nor nor2(out[0], A[0], B[0]);
   if (S < 1)
     parallel_nor #(.S(S-1))parallel_nor0(  A[S-1 : 1],
					    B[S-1 : 1],
					  out[S-1 : 1]);
endmodule // parallel_nor
