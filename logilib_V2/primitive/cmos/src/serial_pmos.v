module serial_pmos(drain, source, gate);
   parameter SIZE = 1;
   output 	    drain;
   input 	    source;
   input [SIZE-1:0] gate;
   wire line;

   if (SIZE > 1)
     serial_pmos #(.SIZE(SIZE-1)) recall(line, source, gate[SIZE-1:1]);

   else
     assign line = source;

   t_pmos inst(drain, line, gate[0]);

endmodule
