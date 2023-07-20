module parallel_xnor(out, A, B);
   parameter SIZE = 3;

   input  [SIZE-1 : 0] A, B;
   output [SIZE-1 : 0] out;

   xnor xnor2(out[0], A[0], B[0]);
   if (SIZE > 1)
     parallel_xnor #(.SIZE(SIZE-1))parallel_xnor0(out[SIZE-1 : 1],
						  A[SIZE-1 : 1],
						  B[SIZE-1 : 1]);
endmodule // parallel_xnor
