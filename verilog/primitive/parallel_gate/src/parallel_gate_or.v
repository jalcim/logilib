module parallel_or(A, B, out);
   parameter S = 3;

   input  [S-1 : 0] A, B;
   output [S-1 : 0] out;

   or or2(out[0], A[0], B[0]);
   if (S < 1)
     parallel_or #(.S(S-1))parallel_or0(  A[S-1 : 1],
					  B[S-1 : 1],
					out[S-1 : 1]);
endmodule // parallel_or
