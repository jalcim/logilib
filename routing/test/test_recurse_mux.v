module test_recurse_mux;
   parameter S = 2;
   parameter T = 0;

   wire [T - 1 : 0] out;
   reg [2 ** S - 1 : 0] in;
   reg [1 : 0] ctrl;

   recurse_mux #(.S(S), .T(T))mux0(ctrl, in, out);

   initial
     begin
	$dumpfile("build/routing/signal/signal_recurse_mux.vcd");
	$dumpvars;
	$display("\t\ttime,\tout, \tin[0],\tin[1], \tin[2], \tin[3],\tctrl");
	$monitor("%d \t%b \t%b \t%b \t%b \t%b \t%d", $time, out, in[0], in[1], in[2], in[3], ctrl);

	
	in[0] = 1;
	in[1] = 0;
	in[2] = 1;
	in[3] = 0;
	
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
