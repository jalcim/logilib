module _test_cpt_bin;

   reg activate, clk, reset;
   wire [7:0] cpt;

   cpt_bin8 test_cpt_bin(activate, clk, reset, cpt);

   initial
     begin
	activate = 0;
	reset = 1;
	clk = 1;
	#5;
	activate = 1;
	reset = 0;
	clk = 1;
	#5;
	activate = 1;
	reset = 0;
	clk = 0;
	#5;
	activate = 1;
	reset = 0;
	clk = 1;
	#5;
	activate = 1;
	reset = 0;
	clk = 0;
	#5;
	activate = 1;
	reset = 0;
	clk = 1;
	#5;
	activate = 1;
	reset = 0;
	clk = 0;
	#5;
	activate = 1;
	reset = 0;
	clk = 1;
	#5;
	activate = 1;
	reset = 0;
	clk = 0;
	#5;
	activate = 1;
	reset = 0;
	clk = 1;
	#5;
	activate = 1;
	reset = 0;
	clk = 0;
	#5;
	activate = 1;
	reset = 0;
	clk = 1;
	#5;
	activate = 1;
	reset = 0;
	clk = 0;
	#5;
	activate = 1;
	reset = 0;
	clk = 1;
	#5;
	activate = 1;
	reset = 0;
	clk = 0;
     end // initial begin
   initial
     begin
	$dumpfile("signal/signal_cpt_bin.vcd");
	$dumpvars;
     end
   initial
     begin
	$display("\t\ttime, \tactivate, \tclk, \treset, \tcpt");
	$monitor("%d \t%b \t\t%b \t%b \t%d", $time, activate, clk, reset, cpt);
     end
endmodule // test_cpt_bin
