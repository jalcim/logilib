`ifndef __SERIAL_DLATCH_RST__
 `define __SERIAL_DLATCH_RST__

module serial_Dlatch_rst(D, clk, rst, Q, QN);
   parameter WIRE = 1;

   input [WIRE -1:0] D;
   input	     clk, rst;
   output [WIRE -1:0] Q, QN;

   not not0(line[0], clk);
   nor nor0(line[1], D[0], line[0]);
   nor nor1(line[2], line[1], line[5]);

   and and2(line[3], clk, D[0]);
   nor nor3(line[4], line[3], line[2]);
   or  or4 (line[5], line[4], rst);

   assign Q[0] = line[2];
   assign QN[0] = line[5];

   if (WIRE > 1)
     serial_Dlatch_rst #(.WIRE(WIRE-1)) recall(.D(D[WIRE-1:1]),
					       .clk(clk),
					       .rst(rst),
					       .Q(Q[WIRE-1:1]),
					       .QN(QN[WIRE-1:1]));
endmodule

`endif
