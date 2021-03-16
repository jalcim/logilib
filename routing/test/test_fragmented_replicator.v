module test_fragmented_replicator;
   parameter WIRE = 3;
   parameter WAY = 1;
   parameter BUS = 1;

   reg [2**(BUS+WIRE) -1:0] in;
   wire [2**(BUS+WAY+WIRE) -1:0] out;

   fragmented_replicator #(.WIRE(WIRE), .WAY(WAY), .BUS(BUS)) fragmented_replicator(in, out);

   initial
     begin
	$dumpfile("build/routing/signal/signal_fragmented_replicator.vcd");
	$dumpvars;
	$display("\t\ttime\tin,\tout1,\tout2\tout3\tout4");
	$monitor("%d\t%d\t%d\t%d\t%d\t%d\n", $time, in, out[7:0], out[15:8],out[23:16], out[31:24]);

	in[7:0] = 170;
	in[15:8] = 180;
	#5;
     end
endmodule // test_replicator
