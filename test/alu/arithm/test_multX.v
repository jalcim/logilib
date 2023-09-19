`include "src/alu/arithm/multX.v"

module test_multX();
   parameter SIZE = 8;

   reg [SIZE -1:0] A, B;
   
   multX #(.SIZE(SIZE)) inst_multX();

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
