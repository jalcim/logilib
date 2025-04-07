`include "src/routing/demux.v"

module test_demux;
   parameter WAY = 4;
   parameter WIRE = 1;

   localparam SIZE_OUT = WAY * WIRE;
   wire [SIZE_OUT - 1 : 0] out;
   reg [WIRE - 1 : 0] in;
   reg [1:0] ctrl;

   demux #(.WAY(WAY), .WIRE(WIRE)) demux0(ctrl, in, out);

   initial
     begin
	$dumpfile("signal_demux.vcd");
	$dumpvars(0, test_demux);
	$display("Time\tOUT[0]\tOUT[1]\tOUT[2]\tOUT[3]\tIN\tCTRL");

	in = 1;

	ctrl = 2'b00; #5;
	ctrl = 2'b01; #5;
	ctrl = 2'b10; #5;
	ctrl = 2'b11; #5;
	$finish;
     end

   initial
     $monitor("%0t\t%b\t%b\t%b\t%b\t%b\t%b", $time, out[0], out[1], out[2], out[3], in, ctrl);
endmodule
