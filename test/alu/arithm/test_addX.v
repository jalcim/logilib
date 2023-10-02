`include "src/alu/arithm/addX.v"

module test_addX;
   parameter WIRE = 8;
   reg [WIRE-1:0] a, b;
   reg		  cin;
   wire [WIRE-1:0] out;
   wire		   cout;

   addX #(.WIRE(WIRE)) addX_inst(a, b, cin, out, cout);

   initial
     begin
	$dumpfile("signal_addX.vcd");
	$dumpvars;
	$display("\t\ttime,\ta,\tb, \tcin, \tout,\tcout");
	$monitor("%d \t%d \t%d \t%b \t%d \t%b", $time, a, b, cin, out, cout);

	a <= 0;
	b <= 0;
	cin <= 0;
	#100;
	a <= 24;
	b <= 0;
	cin <= 0;
	#100;
	a <= 0;
	b <= 54;
	cin <= 0;
	#100;
	a <= 23;
	b <= 54;
	cin <= 0;
	#100;
	a <= 23;
	b <= 54;
	cin <= 1;
	#100;
     end
endmodule
