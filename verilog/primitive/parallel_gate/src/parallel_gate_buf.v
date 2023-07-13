module parallel_buf(A, out);
   parameter S = 3;

   input  [S-1 : 0] A;
   output [S-1 : 0] out;

   buf buf2(out[0], A[0]);
   if (S < 1)
     parallel_buf #(.S(S-1))parallel_buf0(  A[S-1 : 1],
					  out[S-1 : 1]);
endmodule // parallel_buf
