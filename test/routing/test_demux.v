`include "src/routing/demux.v"

module test_demux;
   localparam SIZE_CTRL = 2;
   parameter WIRE = 1;

   wire [((2 ** SIZE_CTRL) * WIRE) - 1 : 0] out;
   reg [WIRE - 1 : 0] in;
   reg [SIZE_CTRL-1 : 0] ctrl;

   demux #(.SIZE_CTRL(SIZE_CTRL), .WIRE(WIRE))demux0(ctrl, in, out);

   initial
     begin
	$dumpfile("signal_demux.vcd");
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
