module serial_JKlatchUP_rst(J, K, clk, reset, Q, QN);
   parameter SIZE = 1;
   input [SIZE -1:0] J, K;
   input	     clk, reset;
   output [SIZE -1:0] Q, QN;

   if (SIZE > 0)
     JKlatchUP_rst JKlatchUP_rst_inst(J[0], K[0], clk, reset, Q[0], QN[0]);
   if (SIZE > 1)
     serial_JKlatchUP_rst #(.SIZE(SIZE-1)) recall(.J(J[SIZE-1:1]),
						  .K(K[SIZE-1:1]),
						  .clk(clk),
						  .reset(reset),
						  .Q(Q[SIZE-1:1]),
						  .QN(QN[SIZE-1:1]));
endmodule

module serial_JKlatchDown_rst(J, K, clk, reset, Q, QN);
   parameter SIZE = 1;
   input [SIZE -1:0] J, K;
   input	     clk, reset;
   output [SIZE -1:0] Q, QN;

   if (SIZE > 0)
     JKlatchDown_rst JKlatchDown_rst_inst(J[0], K[0], clk, Q[0], QN[0]);
   if (SIZE > 1)
     serial_JKlatchDown_rst #(.SIZE(SIZE-1)) recall(.J(J[SIZE-1:1]),
						    .K(K[SIZE-1:1]),
						    .clk(clk),
						    .reset(reset),
						    .Q(Q[SIZE-1:1]),
						    .QN(QN[SIZE-1:1]));
endmodule
