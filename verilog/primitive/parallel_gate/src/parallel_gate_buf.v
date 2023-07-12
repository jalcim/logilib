module parallel_buf(in, out);
   parameter S = 3;

   input [2**S -1 : 0] in;
   output [2**S -1 : 0] out;

   if (S == 0)
     begin
	buf buf2(in[0], out[0]);
     end
   else if (S == 1)
     begin
	buf buf0(in[0], out[0]);
	buf buf1(in[1], out[1]);
     end
   else
     begin
	parallel_buf #(.S(S-1))parallel_buf0(in[2**(S-1) -1: 0],
					       out[2**(S-1) -1: 0]);
	parallel_buf #(.S(S-1))parallel_buf1(in[2**S - 1:2**(S-1)],
					       out[2**S - 1:2**(S-1)]);
     end
endmodule // parallel_buf
