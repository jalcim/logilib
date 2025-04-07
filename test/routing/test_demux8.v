`include "src/routing/demux.v"

module test_demux8;
   parameter WAY = 4;
   parameter WIRE = 8;

   localparam SIZE_CTRL = 2;
   localparam SIZE_OUT = WAY * WIRE;

   wire [SIZE_OUT - 1 : 0] out;
   reg [WIRE - 1 : 0] in;
   reg [SIZE_CTRL - 1 : 0] ctrl;

   integer cpt;
   reg xin;

   demux #(.WAY(WAY), .WIRE(WIRE)) demux0(ctrl, in, out);

   initial
     begin
	$dumpfile("signal_demux8.vcd");
	$dumpvars;
	$display("\t\ttime, \tout[0],\tout[1],\tout[2],\tout[3],\tin,\tctrl");
	$monitor("%d \t%d \t%d \t%d \t%d \t%d \t%d", 
		 $time, out[7:0], out[15:8], out[23:16], out[31:24], in, ctrl);

	xin = 0;
	for (cpt = 0; cpt < SIZE_OUT; cpt = cpt + 1)
	  begin
	     in[cpt] = (cpt % 2) ? 1'b1 : 1'b0;
	  end

	ctrl = 0;  #5;
	ctrl = 1;  #5;
	ctrl = 2;  #5;
	ctrl = 3;  #5;
	$finish;
     end
endmodule
