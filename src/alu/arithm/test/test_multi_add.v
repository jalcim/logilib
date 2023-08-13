module test_multi_add;
   parameter S = 3;

   reg [2**S-1:0] a, b;
   reg 	     cin, sub;
   wire [2**S-1:0] s;
   wire       cout;

   multi_add #(.S(S))multi_add0(a, b, cin, sub, s, cout);

   initial
     begin
	$dumpfile("build/alu/arithm/signal/signal_multi_add.vcd");
	$dumpvars;
	$display("\t\ttime,\ta,\tb, \tcin, \tsub,\ts,\tcout");
	$monitor("%d \t%d \t%d \t%b \t%b \t%d \t%b", $time, a, b, cin, sub, s, cout);

	a = 0;
	b = 255;
	cin = 0;
	sub = 0;
	#100;
	sub = 1;
	#100;
	b = 2;
	#100;
	a = 4;
     end
   
endmodule // test_multi_add
