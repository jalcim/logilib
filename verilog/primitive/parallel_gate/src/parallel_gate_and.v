module parallel_and(out, A, B);
   parameter SIZE = 3;

   input  [SIZE-1 : 0] A, B;
   output [SIZE-1 : 0] out;

   and and2(out[0], A[0], B[0]);
   if (SIZE > 1)
     parallel_and #(.SIZE(SIZE-1))parallel_and0(out[SIZE-1 : 1],
						A[SIZE-1 : 1],
						B[SIZE-1 : 1]);
endmodule // parallel_and
