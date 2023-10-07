`ifndef __SERIAL_DLATCH_RST_PRE__
 `define __SERIAL_DLATCH_RST_PRE__

`include "src/memory/Dlatch/Dlatch_rst_pre.v"

module serial_Dlatch_pre(D, clk, rst, pre, Q, QN);
   parameter WIRE = 1;

   input [WIRE -1:0] D, pre;
   input	     clk, rst;
   output [WIRE -1:0] Q, QN;

   if (WIRE > 0)
     Dlatch_pre latch1(D[0], clk, pre[0], rst, Q[0], QN[0]);
   if (WIRE > 1)
     serial_Dlatch_pre #(.WIRE(WIRE-1)) recall(.D(D[WIRE-1:1]),
					       .clk(clk),
					       .pre(pre[WIRE-1:1]),
					       .rst(rst),
					       .Q(Q[WIRE-1:1]),
					       .QN(QN[WIRE-1:1]));
endmodule

`endif
