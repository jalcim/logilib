`ifndef __PARALLEL_BUF__
 `define __PARALLEL_BUF__

module parallel_buf(out, A);
   parameter SIZE = 8;

   input  [SIZE-1 : 0] A;
   output [SIZE-1 : 0] out;

   buf buf2(out[0], A[0]);
   if (SIZE > 1)
     parallel_buf #(.SIZE(SIZE-1))parallel_buf0(out[SIZE-1 : 1],
						A[SIZE-1 : 1]);
endmodule // parallel_buf

`endif
