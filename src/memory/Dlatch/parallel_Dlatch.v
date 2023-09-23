`include "src/memory/Dlatch/Dlatch.v"
`include "src/memory/Dlatch/serial_Dlatch.v"

module parallel_Dlatch(D, clk, Q, QN);
   parameter WAY = 3;
   parameter WIRE = 8;

   input [WAY-1:0] clk;
   input [(WAY*WIRE)-1 : 0] D;
   output [(WAY*WIRE)-1 : 0] Q, QN;

   if (WIRE == 1)
     Dlatch Dlatch0(D[0], clk[0], Q[0], QN[0]);
   else if (WIRE > 1)
     serial_Dlatch #(.WIRE(WIRE)) Dlatch1(D[WIRE-1:0], clk[0], Q[WIRE-1:0], QN[WIRE-1:0]);

   if (WAY > 1)
     parallel_Dlatch #(.WAY(WAY-1), .WIRE(WIRE)) parallel_Dlatch0(D[WAY*WIRE-1 : WIRE],
								  clk[WAY-1:1],
								  Q[WAY*WIRE-1 : WIRE],
								  QN[WAY*WIRE-1 : WIRE]);
endmodule
