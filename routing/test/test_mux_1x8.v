module test_mux_1x8;
   reg [2:0] s0;
   reg 	     a, b, c, d;

   wire      s;

   multiplexeur_1x8 mux1(s0, a,b,c,d,e,f,g,h, s);

   initial
     begin
	s0 = 0;
	a = 1;
	b = 1;
	c = 1;
	d = 1;
	#5;
	s0 = 1;
	a = 1;
	b = 1;
	c = 1;
	d = 1;
	#5;
	s0 = 2;
	a = 1;
	b = 1;
	c = 1;
	d = 1;
	#5;
	s0 = 3;
	a = 1;
	b = 1;
	c = 1;
	d = 1;
	#5;
     end
   initial
     begin
	$dumpfile("signal/signal_mux.vcd");
	$dumpvars;
     end
   initial
     begin
	$display("\t\ttime,\ts0, \ta,\tb, \tc, \td,\ts");
	$monitor("%d \t%d \t%b \t%b \t%b \t%b \t%b", $time, s0, a, b, c, d, s);
     end
endmodule // testmux
