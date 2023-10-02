`include "src/routing/replicator.v"

module test_replicator;
   parameter WAY = 2;
   parameter WIRE = 8;

   reg  [    WIRE-1:0] in;
   wire [WAY*WIRE-1:0] out;

   replicator #(.WAY(WAY), .WIRE(WIRE)) replicator(out, in);

   initial
     begin
	$dumpfile("signal_replicator.vcd");
	$dumpvars;
	$display("\t\ttime\tin,\tout");
	$monitor("%d\t%b\t%b\n", $time, in, out);

	in = 187;
	#10;
	in = 203;
	#10;
     end
endmodule // test_replicator
