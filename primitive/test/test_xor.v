module test_xor;
   reg a, b;
   wire s;

   gate_xor xor1(a, b, s);

   initial
     begin
	a = 0;
	b = 0;
	#5;
	a = 1;
	b = 0;
	#5;
	a = 0;
	b = 1;
	#5;
	a = 1;
	b = 1;
     end // initial begin

   initial
     begin
	$dumpfile("xor.vcd");
	$dumpvars;
     end

   initial
     begin
	$display("\ttime,\ta,\tb, \ts");
	$monitor("%d \t%b \t%b \t%b", $time, a, b, s);
     end
endmodule // test_primitive
