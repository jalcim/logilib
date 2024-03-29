`include "src/alu/arithm/add.v"

module test_add;
   reg a, b, cin, sub;
   wire s, cout;

   add test_add(a, b, cin, s, cout);

   initial
     begin
	$dumpfile("signal_add.vcd");
	$dumpvars;
	$display("\t\ttime,\ta,\tb, \tcin, \tsub,\ts,\tcout");
	$monitor("%d \t%b \t%b \t%b \t%b \t%b \t%b", $time, a, b, cin, sub, s, cout);

	a = 0;
	b = 0;
	cin = 0;
	sub = 0;
	#5;
	a = 1;
	b = 0;
	cin = 0;
	sub = 0;
	#5;
	a = 0;
	b = 1;
	cin = 0;
	sub = 0;
	#5;
	a = 1;
	b = 1;
	cin = 0;
	sub = 0;
	#5;
	a = 0;
	b = 0;
	cin = 1;
	sub = 0;
	#5;
	a = 1;
	b = 0;
	cin = 1;
	sub = 0;
	#5;
	a = 0;
	b = 1;
	cin = 1;
	sub = 0;
	#5;
	a = 1;
	b = 1;
	cin = 1;
	sub = 0;
	#5;
	a = 0;
	b = 0;
	cin = 0;
	sub = 1;
	#5;
	a = 1;
	b = 0;
	cin = 0;
	sub = 1;
	#5;
	a = 0;
	b = 1;
	cin = 0;
	sub = 1;
	#5;
	a = 1;
	b = 1;
	cin = 0;
	sub = 1;
	#5;
	a = 0;
	b = 0;
	cin = 1;
	sub = 1;
	#5;
	a = 1;
	b = 0;
	cin = 1;
	sub = 1;
	#5;
	a = 0;
	b = 1;
	cin = 1;
	sub = 1;
	#5;
	a = 1;
	b = 1;
	cin = 1;
	sub = 1;
     end
endmodule // test
