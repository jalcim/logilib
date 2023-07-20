module parallel_not(out, A);
   parameter SIZE = 3;

   input  [SIZE-1 : 0] A;
   output [SIZE-1 : 0] out;

   not not2(out[0], A[0]);
   if (SIZE > 1)
     parallel_not #(.SIZE(SIZE-1))parallel_not0(out[SIZE-1 : 1],
						A[SIZE-1 : 1]);
endmodule // parallel_not
