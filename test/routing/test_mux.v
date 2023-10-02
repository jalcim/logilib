`include "src/routing/mux.v"

module test_mux;
   parameter SIZE_CTRL = 2;
   parameter WIRE = 1;

   wire [WIRE - 1 : 0] out;
   reg [2 ** SIZE_CTRL - 1 : 0] in;
   reg [1 : 0] ctrl;

   mux #(.SIZE_CTRL(SIZE_CTRL), .WIRE(WIRE)) mux0(ctrl, in, out);

   initial
     begin
	$dumpfile("signal_mux.vcd");
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
