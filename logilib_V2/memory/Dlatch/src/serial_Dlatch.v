module serial_Dlatch(a, clk, reset, s1, s2);
   parameter SIZE = 1;
   input [SIZE -1:0] a, b;
   input	     clk, reset;
   output [SIZE -1:0] s1, s2;

   if (SIZE > 0)
     Dlatch latch1(a[0], clk, reset, s1[0], s2[0]);
   if (SIZE > 1)
     serial_Dlatch #(.SIZE(SIZE-1)) recall(a[SIZE-1:1], clk, s1[SIZE-1:1], s2[SIZE-1:1]);
endmodule
