module parallel_nand(A, B, out);
   parameter S = 3;

   input  [S-1 : 0] A, B;
   output [S-1 : 0] out;

   nand nand2(out[0], A[0], B[0]);
   if (S < 1)
     parallel_nand #(.S(S-1))parallel_nand0( A[S-1 : 1],
					     B[S-1 : 1],
					    out[S-1 : 1]);
endmodule // parallel_nand
