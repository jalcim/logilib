`ifndef __PARALLEL_DLATCH__
 `define __PARALLEL_DLATCH__

`include "src/memory/Dlatch/Dlatch.v"
`include "src/memory/Dlatch/serial_Dlatch/serial_Dlatch.v"

module parallel_Dlatch(D, clk, Q, QN);
   parameter WAY = 1;
   parameter WIRE = 1;

   input [WAY-1:0] clk;
   input [(WAY*WIRE)-1 : 0] D;
   output [(WAY*WIRE)-1 : 0] Q, QN;

   serial_Dlatch #(.WIRE(WIRE)) serial_inst(D[WIRE-1:0], clk[0], Q[WIRE-1:0], QN[WIRE-1:0]);
   if (WAY > 1)
     parallel_Dlatch #(.WAY(WAY-1), .WIRE(WIRE)) recall(D[WAY*WIRE-1 : WIRE],
							clk[WAY-1:1],
							Q[WAY*WIRE-1 : WIRE],
							QN[WAY*WIRE-1 : WIRE]);
endmodule

`endif
