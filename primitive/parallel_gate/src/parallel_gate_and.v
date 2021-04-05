module parallel_gate_and(in1, in2, out);
   parameter S = 3;

   input [2**S -1 : 0] in1, in2;
   output [2**S -1 : 0] out;

   if (S == 0)
     begin
	gate_and and2(in1[0], in2[0], out[0]);
     end
   else if (S == 1)
     begin
	gate_and and0(in1[0], in2[0], out[0]);
	gate_and and1(in1[1], in2[1], out[1]);
     end
   else
     begin
	parallel_gate_and #(.S(S-1))parallel_gate_and0(in1[2**(S-1) -1: 0],
					       in2[2**(S-1) -1: 0],
					       out[2**(S-1) -1: 0]);
	parallel_gate_and #(.S(S-1))parallel_gate_and1(in1[2**S - 1:2**(S-1)],
					       in2[2**S - 1:2**(S-1)],
					       out[2**S - 1:2**(S-1)]);
     end
endmodule // parallel_gate_and