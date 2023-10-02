`ifndef __SERIAL_DLATCH__
 `define __SERIAL_DLATCH__

 `include "src/memory/Dlatch/Dlatch.v"

module serial_Dlatch(D, clk, Q, QN);
   parameter WIRE = 1;

   input	  clk;
   input [WIRE -1:0] D;
   output [WIRE -1:0] Q, QN;

   if (WIRE > 0)
     Dlatch latch1(D[0], clk, Q[0], QN[0]);
   if (WIRE > 1)
     serial_Dlatch #(.WIRE(WIRE-1)) recall(.D(D[WIRE-1:1]),
					   .clk(clk),
					   .Q(Q[WIRE-1:1]),
					   .QN(QN[WIRE-1:1]));
endmodule

`endif
