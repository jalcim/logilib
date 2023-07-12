module test_Dflipflop;
   reg a, clk, reset;
   wire s1, s2;

   Dflip_flop test_Dflipflop(a, clk, reset, s1, s2);

   initial
     begin
	$dumpfile("build/memory/signal/signal_Dflipflop.vcd");
	$dumpvars;
	$display("\t\ttime, \ta, \tclk, \ts1, \ts2");
	$monitor("%d \t%b \t%b \t%b \t%b", $time, a, clk, s1, s2);

	a = 0;
	clk = 0;
	reset = 1;
	#5;
	a = 0;
	clk = 0;
	reset = 0;
	#5;
	a = 1;
	clk = 1;
	reset = 0;
	#5;
	a = 0;
	clk = 0;
	reset = 0;
	#5;
	a = 0;
	clk = 1;
	reset = 0;
	#5;
	a = 0;
	clk = 0;
	reset = 0;
	#5;
	a = 1;
	clk = 0;
	reset = 0;
	#5;
	a = 0;
	clk = 1;
	reset = 0;
	#5;
	a = 1;
	clk = 1;
	reset = 0;
	#5;
	a = 0;
	clk = 0;
	reset = 1;
	#5;
     end // initial begin

endmodule // test_Dflipflop
