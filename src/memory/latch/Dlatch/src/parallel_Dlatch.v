`include "Dlatch.v"
`include "serial_Dlatch.v"

module parallel_Dlatch(D, clk, Q, QN);
   parameter WAY = 3;
   parameter SIZE = 8;

   input clk;
   input  [(WAY*SIZE)-1 : 0] D;
   output [(WAY*SIZE)-1 : 0] Q, QN;

   if (SIZE == 1)
     Dlatch Dlatch0(D[0], clk, Q[0], QN[0]);
   else if (SIZE > 1)
     serial_Dlatch #(.SIZE(SIZE)) Dlatch1(data[SIZE-1:0], clk, Q[SIZE-1:0], QN[SIZE-1:0]);
     
   if (WAY > 1)
     parallel_Dlatch #(.WAY(WAY-1), .SIZE(SIZE)) parallel_Dlatch0(D[WAY*SIZE-1 : SIZE],
								  clk,
								  Q[WAY*SIZE-1 : SIZE],
								  QN[WAY*SIZE-1 : SIZE]);
endmodule
