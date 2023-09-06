`include "Dlatch_rst.v"

module serial_Dlatch_rst(data, clk, Q, QN);
   parameter WIRE = 1;

   input [WIRE -1:0] data;
   input	     clk;
   output [WIRE -1:0] Q, QN;

   if (WIRE > 0)
     Dlatch_rst latch1(data[0], clk, Q[0], QN[0]);
   if (WIRE > 1)
     serial_Dlatch_rst #(.WIRE(WIRE-1)) recall(.data(data[WIRE-1:1]),
					   .clk(clk),
					   .Q(Q[WIRE-1:1]),
					   .QN(QN[WIRE-1:1]));
endmodule
