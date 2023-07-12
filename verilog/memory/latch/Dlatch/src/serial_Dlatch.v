module serial_Dlatch(data, clk, reset, Q, QN);
   parameter SIZE = 1;
   input [SIZE -1:0] data, b;
   input	     clk, reset;
   output [SIZE -1:0] Q, QN;

   if (SIZE > 0)
     Dlatch latch1(data[0], clk, reset, Q[0], QN[0]);
   if (SIZE > 1)
     serial_Dlatch #(.SIZE(SIZE-1)) recall(.data(data[SIZE-1:1]),
					   .clk(clk),
					   .reset(reset),
					   .Q(Q[SIZE-1:1]),
					   .QN(QN[SIZE-1:1]));
endmodule
