module parallel_xnor(in1, in2, out);
   parameter S = 3;

   input [2**S -1 : 0] in1, in2;
   output [2**S -1 : 0] out;

   if (S == 0)
     begin
	xnor xnor2(in1[0], in2[0], out[0]);
     end
   else if (S == 1)
     begin
	xnor xnor0(in1[0], in2[0], out[0]);
	xnor xnor1(in1[1], in2[1], out[1]);
     end
   else
     begin
	parallel_xnor #(.S(S-1))parallel_xnor0(in1[2**(S-1) -1: 0],
					       in2[2**(S-1) -1: 0],
					       out[2**(S-1) -1: 0]);
	parallel_xnor #(.S(S-1))parallel_xnor1(in1[2**S - 1:2**(S-1)],
					       in2[2**S - 1:2**(S-1)],
					       out[2**S - 1:2**(S-1)]);
     end
endmodule // parallel_xnor
