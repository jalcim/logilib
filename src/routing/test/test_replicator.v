module test_replicator;
   parameter WIRE = 3;
   parameter WAY = 2;

   reg [2**WIRE-1:0] in;
   wire [(2**WAY)*(2**WIRE) -1:0] out;

   replicator #(.WIRE(WIRE), .WAY(WAY)) replicator(in[7:0], out);

   initial
     begin
	$dumpfile("build/routing/signal/signal_replicator.vcd");
	$dumpvars;
	$display("time\t\tin,\tout1,\tout2");
	$monitor("%d\t%d\t%d\t%d\n", $time, in, out[7:0], out[15:8]);

	in = 187;
	#5;
	in = 203;
	#5;
     end
endmodule // test_replicator
