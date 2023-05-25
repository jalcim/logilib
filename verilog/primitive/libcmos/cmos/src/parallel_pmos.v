module parallel_pmos(drain, source, gate);
   parameter SIZE = 1;
   input [SIZE-1:0] source, gate;
   output [SIZE-1:0] drain;

   if (SIZE > 0)
     t_pmos inst(drain[0], source[0], gate[0]);
   if (SIZE > 1)
     parallel_pmos #(.SIZE(SIZE-1)) recall(drain[SIZE-1:1],
					 source[SIZE-1:1],
					 gate[SIZE-1:1]);
endmodule
