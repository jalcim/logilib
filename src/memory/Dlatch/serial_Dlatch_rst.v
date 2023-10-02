`ifndef __SERIAL_DLATCH_RST__
 `define __SERIAL_DLATCH_RST__

`include "src/memory/Dlatch/Dlatch_rst.v"

module serial_Dlatch_rst(data, clk, rst, Q, QN);
   parameter WIRE = 1;

   input [WIRE -1:0] data;
   input	     clk, rst;
   output [WIRE -1:0] Q, QN;

   if (WIRE > 0)
     Dlatch_rst latch1(data[0], clk, rst, Q[0], QN[0]);
   if (WIRE > 1)
     serial_Dlatch_rst #(.WIRE(WIRE-1)) recall(.data(data[WIRE-1:1]),
					       .clk(clk),
					       .rst(rst),
					       .Q(Q[WIRE-1:1]),
					       .QN(QN[WIRE-1:1]));
endmodule

`endif
