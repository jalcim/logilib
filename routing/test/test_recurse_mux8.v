module test_recurse_mux;
   parameter S = 2;
   parameter T = 8;

   wire [T - 1 : 0] out;
   reg [(2 ** S) * T - 1 : 0] in;
   reg [S-1 : 0] ctrl;

   integer     cpt;
   reg 	       xin;

   recurse_mux #(.S(S), .T(T)) mux0(ctrl, in, out);

   initial
     begin
	$dumpfile("build/routing/signal/signal_recurse_mux8.vcd");
	$dumpvars;
	$display("\t\ttime,\tout,\ts");
	$monitor("%d\t%d\t%d", $time, out[7:0], ctrl[1:0]);

	cpt = -1;
	xin = 0;
	while (++cpt <= (2**S) * T - 1)
	  begin
	     in[cpt] = xin;
	     xin = ~xin;
	  end  

	ctrl[0] = 0;
	ctrl[1] = 0;
	#5;
	ctrl[0] = 1;
	ctrl[1] = 0;
	#5;
	ctrl[0] = 0;
	ctrl[1] = 1;
	#5;
	ctrl[0] = 1;
	ctrl[1] = 1;
	#5;
     end
endmodule
