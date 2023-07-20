module parallel_xor(out, A, B);
   parameter SIZE = 8;

   input  [SIZE-1 : 0] A, B;
   output [SIZE-1 : 0] out;

   xor xor2(out[0], A[0], B[0]);
   if (SIZE > 1)
     parallel_xor #(.SIZE(SIZE-1))parallel_xor0(out[SIZE-1 : 1],
						A[SIZE-1 : 1],
						B[SIZE-1 : 1]);
endmodule // parallel_xor
