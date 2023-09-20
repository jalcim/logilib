`include "src/routing/shuffle.v"

module test_shuffle;
   parameter WAY = 3;
   parameter WIRE = 5;

   reg [WIRE-1:0] e1, e2, e3;

   wire [WAY*WIRE-1:0] out;

   shuffle #(.WAY(WIRE), .WIRE(WAY)) inst_shuffle(out, {e3, e2, e1});

   initial
     begin
	$dumpfile("signal_test_shuffle.vcd");
	$dumpvars;
	$display("\t\ttime, \tout\t\t\te1\te2\te3\n");
	$monitor("%d \t%b \t%b \t%b \t%b\n", $time, out, e1, e2, e3);

	e1 <= 5'b11111;
	e2 <= 5'b00000;
	e3 <= 5'b00000;
	#10;
	e1 <= 5'b00000;
	e2 <= 5'b11111;
	e3 <= 5'b00000;
	#10;
	e1 <= 5'b00000;
	e2 <= 5'b00000;
	e3 <= 5'b11111;
	#10;
     end
endmodule
