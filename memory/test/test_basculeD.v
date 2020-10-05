module _test_basculeD;
   reg a, clk, reset;
   wire s1, s2;

   basculeD test_basculeD(a, clk, reset, s1, s2);

   initial
     begin
	a = 0;
	clk = 0;
	reset = 1;
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
	a = 0;
	clk = 0;
	reset = 0;
	#5;
	a = 0;
	clk = 0;
	reset = 1;
	#5;
     end // initial begin
   initial
     begin
	$dumpfile("signal/signal_basculeD.vcd");
	$dumpvars;
     end
   initial
     begin
	$display("\t\ttime, \ta, \tclk, \treset, \ts1, \ts2");
	$monitor("%d \t%b \t%b \t%b \t%b \t%b", $time, a, clk, reset, s1, s2);
     end
endmodule // test_basculeD
