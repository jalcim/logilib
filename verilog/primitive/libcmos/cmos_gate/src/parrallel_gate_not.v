module parallel_gate_not(out, in);
   parameter SIZE = 1;

   input  [SIZE -1 : 0] in;
   output [SIZE -1 : 0] out;
   
   if (SIZE == 1)
     begin
	gate_not not0(out[0], in[0]);
     end
   else
     begin
	parallel_not #(.SIZE(SIZE-1))parallel_not0(out[SIZE/2-1 : 0],
						   in [SIZE/2-1 : 0]);

	parallel_not #(.SIZE(SIZE-1))parallel_not1(out[SIZE-1   : SIZE/2],
						   in [SIZE-1   : SIZE/2]);

     end
endmodule // parallel_not
