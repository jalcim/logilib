module parallel_nor(out, A, B);
   parameter SIZE = 3;

   input  [SIZE-1 : 0] A, B;
   output [SIZE-1 : 0] out;

   nor nor2(out[0], A[0], B[0]);
   if (SIZE > 1)
     parallel_nor #(.SIZE(SIZE-1))parallel_nor0(out[SIZE-1 : 1],
						A[SIZE-1 : 1],
						B[SIZE-1 : 1]);
endmodule // parallel_nor
