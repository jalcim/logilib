module test;
   reg a, b, cin, sub;
   wire s, cout;

   add test_additionneur(a, b, cin, sub, s, cout);

   initial
     begin
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
     end // initial begin
   initial
     begin
	$dumpfile("full_add.vcd");
	$dumpvars;
     end

   initial
     begin
	$display("\t\ttime,\ta,\tb, \tcin, \tsub,\ts,\tcout");
	$monitor("%d \t%b \t%b \t%b \t%b \t%b \t%b", $time, a, b, cin, sub, s, cout);
     end
endmodule // test
