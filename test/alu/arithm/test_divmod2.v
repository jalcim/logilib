`include "src/alu/arithm/divmod2.v"

module test_divmod2;
   reg [7:0] a;
   wire      mod2;
   wire [7:0] div2;

   divmod2 #(.WIRE(8)) test_divmod2(a, div2, mod2);

   initial
     begin
	$dumpfile("signal_divmod2.vcd");
	$dumpvars;
	$display("\t\ttime,\ta, \t\tdiv2, \t\tmod2");
	$monitor("%d \t%b\t%b \t%b", $time, a, div2, mod2);

	a = 0;
	#5;
	a = 1;
	#5;
	a = 2;
	#5;
	a = 4;
	#5;
	a = 8;
	#5;
	a = 16;
	#5;
	a = 32;
	#5;
	a = 33;
	#5;
	a = 40;
	#5;
     end
endmodule // test_divmod2
