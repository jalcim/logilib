module parallel_or(in1, in2, out);
   parameter S = 3;

   input [2**S -1 : 0] in1, in2;
   output [2**S -1 : 0] out;

   if (S == 0)
     begin
	or or2(in1[0], in2[0], out[0]);
     end
   else if (S == 1)
     begin
	or or0(in1[0], in2[0], out[0]);
	or or1(in1[1], in2[1], out[1]);
     end
   else
     begin
	parallel_or #(.S(S-1))parallel_or0(in1[2**(S-1) -1: 0],
					       in2[2**(S-1) -1: 0],
					       out[2**(S-1) -1: 0]);
	parallel_or #(.S(S-1))parallel_or1(in1[2**S - 1:2**(S-1)],
					       in2[2**S - 1:2**(S-1)],
					       out[2**S - 1:2**(S-1)]);
     end
endmodule // parallel_or
