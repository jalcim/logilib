`ifndef __SERIAL_DFLIPFLOP_RST_PRE__
 `define __SERIAL_DFLIPFLOP_RST_PRE__

`include "src/memory/dflipflop/Dflipflop_rst_pre.v"

module serial_Dflipflop_rst_pre(D, clk, rst, pre, Q, QN);
   parameter WIRE = 1;

   input [WIRE -1:0] D, pre;
   input	     clk, rst;
   output [WIRE -1:0] Q, QN;

   /* verilator lint_off UNOPTFLAT *//* verilator lint_off UNOPTFLAT */
   wire [5:0]	      line;

   /* verilator lint_off UNOPTFLAT */
   wire		      line2;

   assign line[0] = ~(rst | line[3] | line2);
   assign line[1] = ~(line2 | clk | line[3]);
   assign line2 = ~(line[0] | pre[0] | clk);
   assign line[3] = ~(line[1] | D[0] | pre[0]);

   assign line[4] = ~(rst | line2 | line[5]);
   assign line[5] = ~(line[4] | line[1] | pre[0]);

   assign Q[0] = line[4];
   assign QN[0] = line[5];

   if (WIRE > 1)
     serial_Dflipflop_rst_pre #(.WIRE(WIRE-1)) recall(.D(D[WIRE-1:1]),
						      .clk(clk),
						      .rst(rst),
						      .pre(pre[WIRE-1:1]),
						      .Q(Q[WIRE-1:1]),
						      .QN(QN[WIRE-1:1]));
endmodule

`endif
