module test_recurse_mux;
   parameter S = 2;
   parameter T = 8;

   wire [T - 1 : 0] z;
   reg [(2 ** S) * T - 1 : 0] d;
   reg [S-1 : 0] s;

   integer     cpt;
   reg 	       xin;

   recurse_mux #(.S(S), .T(T)) mux0(z, d, s);

   initial
     begin
	$dumpfile("build/routing/signal/signal_recurse_mux8.vcd");
	$dumpvars;
	$display("\t\ttime,\tz,\ts");
	$monitor("%d\t%d\t%d", $time, z[7:0], s[1:0]);

	cpt = -1;
	xin = 0;
	while (++cpt <= (2**S) * T - 1)
	  begin
	     d[cpt] = xin;
	     xin = ~xin;
	  end  

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
