`ifndef __SERIAL_DLATCH_PRE__
 `define __SERIAL_DLATCH_PRE__

module serial_Dlatch_pre(D, clk, pre, Q, QN);
   parameter WIRE = 1;

   input [WIRE -1:0] D, pre;
   input	     clk;
   output [WIRE -1:0] Q, QN;

   /* verilator lint_off UNOPTFLAT */
   wire [5:0]		      line;

   /* verilator lint_off UNOPTFLAT */
   wire			      line2;

   not not0(line[0], clk);
   nor nor0(line[1], D[0], line[0]);
   nor nor1(line2, line[1], line[5]);
   or  or2 (line[3], line2, pre[0]);

   and and3(line[4], clk, D[0]);
   nor nor4(line[5], line[4], line[3]);

   assign Q[0] = line[3];
   assign QN[0] = line[5];

   if (WIRE > 1)
     serial_Dlatch_pre #(.WIRE(WIRE-1)) recall(.D(D[WIRE-1:1]),
					       .clk(clk),
					       .pre(pre[WIRE-1:1]),
					       .Q(Q[WIRE-1:1]),
					       .QN(QN[WIRE-1:1]));
endmodule

`endif
