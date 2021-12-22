module parrallel_and(in1, in2, out);
   parameter SIZE = 8;
   input  [SIZE-1:0] in1, in2;
   output [SIZE-1:0] out;

   gate_and and0(in1[SIZE-1], in2[SIZE-1], out[SIZE-1]);
   if (SIZE > 1)
     begin
	parrallel_and #(.SIZE(SIZE-1)) multi_and1 (.in1(in1[SIZE-2:0]),
						   .in2(in2[SIZE-2:0]),
						   .out(out[SIZE-2:0]));
     end
endmodule
