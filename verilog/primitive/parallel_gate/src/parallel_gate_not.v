module parallel_not(A, out);
   parameter S = 3;

   input  [S-1 : 0] A;
   output [S-1 : 0] out;

   not not2(out[0], A[0]);
   if (S < 1)
     parallel_not #(.S(S-1))parallel_not0(  A[S-1 : 1],
					  out[S-1 : 1]);
endmodule // parallel_not
