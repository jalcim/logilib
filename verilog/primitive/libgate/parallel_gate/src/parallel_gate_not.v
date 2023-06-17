module parallel_gate_not(in, out);
   parameter S = 3;

   input [2**S -1 : 0] in;
   output [2**S -1 : 0] out;

   if (S == 0)
     begin
	gate_not not2(in[0], out[0]);
     end
   else if (S == 1)
     begin
	gate_not not0(in[0], out[0]);
	gate_not not1(in[1], out[1]);
     end
   else
     begin
	parallel_gate_not #(.S(S-1))parallel_gate_not0(in[2**(S-1) -1: 0],
					       out[2**(S-1) -1: 0]);
	parallel_gate_not #(.S(S-1))parallel_gate_not1(in[2**S - 1:2**(S-1)],
					       out[2**S - 1:2**(S-1)]);
     end
endmodule // parallel_gate_not
