`ifndef __SERIAL_DLATCH_RST_PRE__
 `define __SERIAL_DLATCH_RST_PRE__

module serial_Dlatch_rst_pre(D, clk, rst, pre, Q, QN);
   parameter WIRE = 1;

   input [WIRE -1:0] D, pre;
   input	     clk, rst;
   output [WIRE -1:0] Q, QN;

   wire [6:0]		      line;

   not not0(line[0], clk);
   nor nor0(line[1], D[0], line[0]);
   nor nor1(line[2], line[1], line[6]);
   or  or2 (line[3], line[2], pre[0]);

   and and3(line[4], clk, D[0]);
   nor nor4(line[5], line[4], line[3]);
   or  or5 (line[6], line[5], rst);

   assign Q[0] = line[3];
   assign QN[0] = line[6];

   if (WIRE > 1)
     serial_Dlatch_rst_pre #(.WIRE(WIRE-1)) recall(.D(D[WIRE-1:1]),
					       .clk(clk),
					       .rst(rst),
					       .pre(pre[WIRE-1:1]),
					       .Q(Q[WIRE-1:1]),
					       .QN(QN[WIRE-1:1]));
endmodule

`endif
