module test_divmod2;
   reg activate, clk, reset;
   reg [7:0] a;
   wire      mod2;
   wire [7:0] div2;
   

   divmod2 test_divmod2(activate, clk, reset, a, div2, mod2);

   initial
     begin
	activate = 0;
	a = 0;
	clk = 0;
	reset = 1;
	#5;
	activate = 1;
	a = 13;
	clk = 1;
	reset = 0;
	#5;
	activate = 1;
	a = 13;
	clk = 0;
	reset = 0;
	#5;
	activate = 1;
	a = 13;
	clk = 1;
	reset = 0;
	#5;
	activate = 1;
	a = 13;
	clk = 0;
	reset = 0;
	#5;
	activate = 1;
	a = 13;
	clk = 1;
	reset = 0;
	#5;
	activate = 1;
	a = 13;
	clk = 0;
	reset = 0;
	#5;
	activate = 0;
	a = 0;
	clk = 1;
	reset = 0;
	#5;
	activate = 0;
	a = 0;
	clk = 0;
	reset = 1;
	#5;
     end // initial begin
   initial
     begin
	$dumpfile("signal/signal_divmod2.vcd");
	$dumpvars;
     end

   initial
     begin
	$display("\t\ttime,\tactivate,\tclk, \treset, \ta, \tdiv2, \t\tmod2");
	$monitor("%d \t%b \t\t%b \t%b \t%d \t%d \t%b", $time, activate, clk, reset, a, div2, mod2);
     end
endmodule // test_divmod2
