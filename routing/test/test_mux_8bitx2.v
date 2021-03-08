module test_mux_8bitx2;
   reg  s0;
   reg 	[7:0] a, b;

   wire [7:0] s;

   multiplexeur_8bitx2 mux1(s0, a, b, s);

   initial
     begin
	$dumpfile("build/routing/signal/signal_mux.vcd");
	$dumpvars;
	$display("\t\ttime,\ts0, \ta,\tb, \ts");
	$monitor("%d \t%b \t%d \t%d \t%d", $time, s0, a, b, s);
	
	s0 = 0;
	a = 23;
	b = 42;
	#5;
	s0 = 1;
	a = 23;
	b = 42;
	#5;
     end
endmodule // test_mux_8bitx2

