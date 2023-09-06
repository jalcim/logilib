`include "Dlatch_rst.v"
`include "serial_Dlatch_rst.v"

module parallel_Dlatch_rst(D, clk, rst, Q, QN);
   parameter WAY = 3;
   parameter SIZE = 8;

   input rst;
   input [WAY-1:0] clk;
   input  [(WAY*SIZE)-1 : 0] D;
   output [(WAY*SIZE)-1 : 0] Q, QN;

   if (SIZE == 1)
     Dlatch_rst Dlatch0(D[0], clk[0], rst, Q[0], QN[0]);
   else if (SIZE > 1)
     serial_Dlatch_rst #(.SIZE(SIZE)) Dlatch1(data[SIZE-1:0], clk[0], rst, Q[SIZE-1:0], QN[SIZE-1:0]);

   if (WAY > 1)
     parallel_Dlatch_rst #(.WAY(WAY-1), .SIZE(SIZE)) parallel_Dlatch0(D[WAY*SIZE-1 : SIZE],
								  clk[WAY-1:1],
								  rst,
								  Q[WAY*SIZE-1 : SIZE],
								  QN[WAY*SIZE-1 : SIZE]);
endmodule
