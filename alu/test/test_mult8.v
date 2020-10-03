module test_mult_8;
   reg activate, clk, reset;
   reg [7:0] a, b, c;

   wire [7:0] div8, div16;
   wire      mod;

   mult_8 test_mult_8(activate, clk, reset, a, b, c, div8, div16);

   initial
     begin
	activate = 0;
	clk = 0;
	reset = 1;
	a = 0;
	b = 0;
	c = 0;
	#5;
	activate = 0;
	clk = 0;
	reset = 1;
	a = 0;
	b = 0;
	c = 0;
	#5;
	//11
	activate = 1;
	clk = 1;
	reset = 0;
	a = 6;
	b = 2;
	c = 5;
	#5;
	activate = 1;//repauto
	clk = 0;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	//12
	activate = 1;//repauto
	clk = 1;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	activate = 1;//repauto
	clk = 0;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	//13
	activate = 1;//repauto
	clk = 1;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	activate = 1;//repauto
	clk = 0;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	//21
	activate = 1;
	clk = 1;
	reset = 0;
	a = 6;
	b = 2;
	c = 5;
	#5;
	activate = 1;//repauto
	clk = 0;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	//22
	activate = 1;//repauto
	clk = 1;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	activate = 1;//repauto
	clk = 0;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	//23
	activate = 1;//repauto
	clk = 1;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	activate = 1;//repauto
	clk = 0;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	//31
	activate = 1;
	clk = 1;
	reset = 0;
	a = 6;
	b = 2;
	c = 5;
	#5;
	activate = 1;//repauto
	clk = 0;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	//32
	activate = 1;//repauto
	clk = 1;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	activate = 1;//repauto
	clk = 0;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	//33
	activate = 1;//repauto
	clk = 1;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	activate = 1;//repauto
	clk = 0;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	//41
	activate = 1;
	clk = 1;
	reset = 0;
	a = 6;
	b = 2;
	c = 5;
	#5;
	activate = 1;//repauto
	clk = 0;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	//42
	activate = 1;//repauto
	clk = 1;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	activate = 1;//repauto
	clk = 0;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	//43
	activate = 1;//repauto
	clk = 1;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	activate = 1;//repauto
	clk = 0;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	//51
	activate = 1;
	clk = 1;
	reset = 0;
	a = 6;
	b = 2;
	c = 5;
	#5;
	activate = 1;//repauto
	clk = 0;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	//52
	activate = 1;//repauto
	clk = 1;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	activate = 1;//repauto
	clk = 0;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	//53
	activate = 1;//repauto
	clk = 1;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	activate = 1;//repauto
	clk = 0;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	//61
	activate = 1;
	clk = 1;
	reset = 0;
	a = 6;
	b = 2;
	c = 5;
	#5;
	activate = 1;//repauto
	clk = 0;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	//62
	activate = 1;//repauto
	clk = 1;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	activate = 1;//repauto
	clk = 0;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	//63
	activate = 1;//repauto
	clk = 1;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	activate = 1;//repauto
	clk = 0;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	//71
	activate = 1;
	clk = 1;
	reset = 0;
	a = 6;
	b = 2;
	c = 5;
	#5;
	activate = 1;//repauto
	clk = 0;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	//72
	activate = 1;//repauto
	clk = 1;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	activate = 1;//repauto
	clk = 0;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	//73
	activate = 1;//repauto
	clk = 1;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	activate = 1;//repauto
	clk = 0;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	//81
	activate = 1;
	clk = 1;
	reset = 0;
	a = 6;
	b = 2;
	c = 5;
	#5;
	activate = 1;//repauto
	clk = 0;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	//82
	activate = 1;//repauto
	clk = 1;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	activate = 1;//repauto
	clk = 0;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	//83
	activate = 1;//repauto
	clk = 1;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	activate = 1;//repauto
	clk = 0;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	//res
	activate = 1;//repauto
	clk = 1;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;
	#5;
	activate = 1;//repauto
	clk = 0;
	reset = 0;
	a = 0;
	b = 0;
	c = 0;

     end // initial begin
   initial
     begin
	$dumpfile("signal/signal_mult8.vcd");
	$dumpvars;
     end

   initial
     begin
	$display("\t\ttime, \tactivate, \tclk, \treset, \ta,\tb, \tc, \tdiv8,\tdiv16");
	$monitor("%d \t\t%b \t%b \t%b \t%d \t%d \t%d \t%d \t%d", $time, activate, clk, reset, a, b, c, div8, div16);
     end
endmodule // test_mult

