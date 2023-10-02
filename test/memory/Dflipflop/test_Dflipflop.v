`include "src/memory/Dflipflop/Dflipflop.v"

module test_Dflipflop;
   reg a, clk, reset, set;
   wire s1, s2;

   Dflipflop test_Dflipflop(set, a, clk, reset, s1, s2);

   initial
     begin
	$dumpfile("signal_Dflipflop.vcd");
	$dumpvars;
	$display("\t\ttime, \ta, \tset, \treset, \tclk, \ts1, \ts2");
	$monitor("%d \t%b \t%b \t%b \t%b \t%b \t%b", $time, a, set, reset, clk, s1, s2);

	set = 0;
	a = 0;
	clk = 0;
	reset = 1;
	#10;
	a = 0;
	clk = 0;
	reset = 0;
	#10;
	a = 1;
	clk = 1;
	reset = 0;
	#10;
	a = 1;
	clk = 0;
	reset = 0;
	#10;
	a = 0;
	clk = 1;
	reset = 0;
	#10;
	a = 1;
	clk = 0;
	reset = 0;
	#10;
	a = 1;
	clk = 1;
	reset = 0;
	#10;
	a = 1;
	clk = 0;
	reset = 0;
	#10;
	a = 1;
	clk = 0;
	reset = 0;
	#10;
	a = 0;
	clk = 1;
	reset = 1;
	#10;
     end // initial begin

endmodule // test_Dflipflop
