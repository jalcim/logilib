module test_recurse_mux;
   parameter S = 2;
   parameter T = 1;

   wire [T - 1 : 0] z;
   reg [2 ** S - 1 : 0] d;
   reg [1 : 0] s;

   recurse_mux #(.S(S), .T(T))mux0(z, d, s);

   initial
     begin
	$dumpfile("signal/signal_recurse_mux.vcd");
	$dumpvars;
	$display("\t\ttime,\tz, \td[0],\td[1], \td[2], \td[3],\ts");
	$monitor("%d \t%b \t%b \t%b \t%b \t%b \t%d", $time, z, d[0], d[1], d[2], d[3], s);

	
	d[0] = 1;
	d[1] = 0;
	d[2] = 1;
	d[3] = 0;
	
	s[0] = 0;
	s[1] = 0;
	#5;
	s[0] = 1;
	s[1] = 0;
	#5;
	s[0] = 0;
	s[1] = 1;
	#5;
	s[0] = 1;
	s[1] = 1;
	#5;
     end
endmodule
