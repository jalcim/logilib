`include "Dlatch_rst.v"

module serial_Dlatch_rst(data, clk, Q, QN);
   parameter SIZE = 1;
   input [SIZE -1:0] data;
   input	     clk;
   output [SIZE -1:0] Q, QN;

   if (SIZE > 0)
     Dlatch_rst latch1(data[0], clk, Q[0], QN[0]);
   if (SIZE > 1)
     serial_Dlatch_rst #(.SIZE(SIZE-1)) recall(.data(data[SIZE-1:1]),
					   .clk(clk),
					   .Q(Q[SIZE-1:1]),
					   .QN(QN[SIZE-1:1]));
endmodule
