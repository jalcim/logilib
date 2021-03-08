module test_recurse_mux;
   parameter S = 2;
   parameter T = 1;

   wire [2 ** S - 1 : 0] out; 
   reg [T - 1 : 0] in;
   reg [1 : 0] ctrl;

   recurse_demux #(.S(S), .T(T))mux0(ctrl, in, out);

   initial
     begin
	$dumpfile("build/routing/signal/signal_recurse_mux.vcd");
	$dumpvars;
	$display("\t\ttime, \tout[0],\tout[1],\tout[2],\tout[3],\tin,\tctrl");
	$monitor("%d \t%b \t%b \t%b \t%b \t%b \t%d", $time, out[0], out[1], out[2], out[3], in, ctrl);
	
	in[0] = 1;
	
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
