module test_bit_cpt3;

   reg activate, clk, reset;
   wire [2:0] cpt;

   bit_cpt3 test_bit_cpt3(activate, clk, reset, cpt);

   initial
     begin
	activate = 0;
	clk = 1;
	reset = 1;
	#5;
	activate = 0;
	clk = 0;
	reset = 0;
	#5;
	activate = 1;
	clk = 0;
	reset = 0;
	#5;
	activate = 1;
	clk = 1;
	reset = 0;
	#5;
	activate = 0;
	clk = 0;
	reset = 0;
	#5;
	activate = 0;
	clk = 1;
	reset = 0;
	#5;
	activate = 0;
	clk = 0;
	reset = 0;
	#5;
	activate = 1;
	clk = 1;
	reset = 0;
	#5;
	activate = 1;
	clk = 0;
	reset = 0;
	reset = 0;
	#5;
	activate = 1;
	clk = 1;
	reset = 0;
	#5;
	activate = 1;
	clk = 0;
	reset = 0;
	#5;
	activate = 1;
	clk = 1;
	reset = 1;
	#5;
	activate = 1;
	clk = 0;
	reset = 0;
	#5;
	activate = 0;
	clk = 1;
	reset = 0;
	#5;
	activate = 0;
	clk = 0;
	reset = 0;
	#5;
     end // initial begin
   initial
     begin
	$dumpfile("signal/signal_bit_cpt3.vcd");
	$dumpvars;
     end
   initial
     begin
	$display("\t\ttime, \tactivate, \tclk, \treset, \tcpt");
	$monitor("%d \t%b \t\t%b \t%b \t%d", $time, activate, clk, reset, cpt);
     end
endmodule // test_bit_cpt3
