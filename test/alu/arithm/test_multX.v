`include "src/alu/arithm/multX.v"

module test_multX();
   parameter WIRE = 8;

   reg [WIRE-1:0] A, B;
   wire [WIRE-1:0] out;

   multX #(.WIRE(WIRE)) inst_multX(A, B, 8'b0, out);

   initial
     begin
	$dumpfile("signal_multX.vcd");
	$dumpvars;
	$display("\t\ttime,\tA,\tB, \tout");
	$monitor("%d \t%d \t%d \t%d", $time, A, B, out);

	A <= 0;
	B <= 0;
	#10;
	A <= 3;
	B <= 5;
	#10;
	A <= 8;
	B <= 12;
	#10;
	A <= 3;
	B <= 10;
	#10;
     end
endmodule
