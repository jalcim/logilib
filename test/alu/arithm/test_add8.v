`include "src/alu/arithm/add_sub.v"

module test_add8;
   parameter WIRE = 8;
   reg [7:0] a, b;
   reg 	     cin, sub;
   wire [7:0] s;
   wire       cout;

   add_sub #(.WIRE(WIRE)) test_addX(a, b, cin, sub, s, cout);

   initial
     begin
	$dumpfile("signal_add8.vcd");
	$dumpvars;
	$display("\t\ttime,\ta,\tb, \tcin, \tsub,\ts,\tcout");
	$monitor("%d \t%d \t%d \t%b \t%b \t%d \t%b", $time, a, b, cin, sub, s, cout);

	a = 0;
	b = 0;
	cin = 0;
	sub = 0;
	#5;
	a = 22;
	b = 0;
	cin = 0;
	sub = 0;
	#5;
	a = 0;
	b = 83;
	cin = 0;
	sub = 0;
	#5;
	a = 22;
	b = 83;
	cin = 0;
	sub = 0;
	#5;
	a = 0;
	b = 0;
	cin = 0;
	sub = 1;
	#5;
	a = 24;
	b = 0;
	cin = 0;
	sub = 1;
	#5;
	a = 0;
	b = 12;
	cin = 0;
	sub = 1;
	#5;
	a = 24;
	b = 12;
	cin = 0;
	sub = 1;
	#5;
	a = 0;
	b = 255;
	cin = 0;
	sub = 1;

     end
endmodule // test_add8


	
