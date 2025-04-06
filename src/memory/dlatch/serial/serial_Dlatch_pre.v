`ifndef __SERIAL_DLATCH_PRE__
 `define __SERIAL_DLATCH_PRE__

`include "src/memory/dlatch/Dlatch_pre.v"

module serial_Dlatch_pre(D, clk, pre, Q, QN);
   parameter WIRE = 1;

   input [WIRE -1:0] D, pre;
   input	     clk;
   output [WIRE -1:0] Q, QN;

   Dlatch_pre latch1(.D(D[0]),
		     .clk(clk),
		     .pre(pre[0]),
		     .Q(Q[0]),
		     .QN(QN[0]));
   if (WIRE > 1)
     serial_Dlatch_pre #(.WIRE(WIRE-1)) recall(.D(D[WIRE-1:1]),
					       .clk(clk),
					       .pre(pre[WIRE-1:1]),
					       .Q(Q[WIRE-1:1]),
					       .QN(QN[WIRE-1:1]));
endmodule

`endif
