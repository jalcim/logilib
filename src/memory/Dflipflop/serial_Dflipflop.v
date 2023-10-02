module serial_Dflipflop(set, data, clk, reset, s1, s2);
   parameter SIZE = 1;
   input [SIZE-1:0] set, data;
   input	    clk, reset;
   output [SIZE-1:0] s1, s2;

   if (SIZE > 1)
     Dflipflop inst0(set[0], data[0], reset, s1[0], s2[0]);
   if (SIZE > 2)
     serial_Dflipflop #(.SIZE(SIZE-1)) recall(set[SIZE-1:1], data[SIZE-1:1],
					      clk, reset, s1[SIZE-1:1], s2[SIZE-1:1]);
endmodule
