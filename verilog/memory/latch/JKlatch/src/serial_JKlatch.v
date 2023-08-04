module serial_JKlatchUP(J, K, clk, Q, QN);
   parameter SIZE = 1;
   input [SIZE -1:0] J, K;
   input	     clk;
   output [SIZE -1:0] Q, QN;

   if (SIZE > 0)
     JKlatchUP JKlatchUP_inst(J[0], K[0], clk, Q[0], QN[0]);
   if (SIZE > 1)
     serial_DlatchUP #(.SIZE(SIZE-1)) recall(.J(J[SIZE-1:1]),
					     .K(K[SIZE-1:1]),
					     .clk(clk),
					     .Q(Q[SIZE-1:1]),
					     .QN(QN[SIZE-1:1]));
endmodule

module serial_JKlatchDown(J, K, clk, Q, QN);
   parameter SIZE = 1;
   input [SIZE -1:0] J, K;
   input	     clk;
   output [SIZE -1:0] Q, QN;

   if (SIZE > 0)
     JKlatchDown JKlatchDown_inst(J[0], K[0], clk, Q[0], QN[0]);
   if (SIZE > 1)
     serial_JKlatchDown #(.SIZE(SIZE-1)) recall(.J(J[SIZE-1:1]),
						.K(K[SIZE-1:1]),
						.clk(clk),
						.Q(Q[SIZE-1:1]),
						.QN(QN[SIZE-1:1]));
endmodule
