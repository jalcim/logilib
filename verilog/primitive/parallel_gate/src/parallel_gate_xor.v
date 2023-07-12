module parallel_xor(in1, in2, out);
   parameter S = 3;

   input [2**S -1 : 0] in1, in2;
   output [2**S -1 : 0] out;

   if (S == 0)
     begin
	xor xor2(in1[0], in2[0], out[0]);
     end
   else if (S == 1)
     begin
	xor xor0(in1[0], in2[0], out[0]);
	xor xor1(in1[1], in2[1], out[1]);
     end
   else
     begin
	parallel_xor #(.S(S-1))parallel_xor0(in1[2**(S-1) -1: 0],
					       in2[2**(S-1) -1: 0],
					       out[2**(S-1) -1: 0]);
	parallel_xor #(.S(S-1))parallel_xor1(in1[2**S - 1:2**(S-1)],
					       in2[2**S - 1:2**(S-1)],
					       out[2**S - 1:2**(S-1)]);
     end
endmodule // parallel_xor
