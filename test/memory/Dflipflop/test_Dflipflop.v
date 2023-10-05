`include "src/memory/Dflipflop/Dflipflop.v"

module test_Dflipflop;
   reg a, clk;
   wire Q, QN;

   Dflipflop test_Dflipflop(set, a, Q, QN);

   initial
     begin
	$dumpfile("signal_Dflipflop.vcd");
	$dumpvars;
	$display("\t\ttime, \ta, \tclk, \tQ, \tQN");
	$monitor("%d \t%b \t%b \t%b \t%b", $time, a, clk, Q, QN);

	a = 0;
	clk = 0;
	#10;
	a = 0;
	clk = 0;
	#10;
	a = 1;
	clk = 1;
	#10;
	a = 1;
	clk = 0;
	#10;
	a = 0;
	clk = 1;
	#10;
	a = 1;
	clk = 0;
	#10;
	a = 1;
	clk = 1;
	#10;
	a = 1;
	clk = 0;
	#10;
	a = 1;
	clk = 0;
	#10;
	a = 0;
	clk = 1;
	#10;
     end

endmodule
