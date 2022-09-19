module _test_multi_xor;
   parameter SIZE = 3;

   reg [SIZE-1:0] e1;
   wire out;
   reg	clk;
   integer i;

   multi_xor #(.SIZE(SIZE)) test_multi_xor(out, e1);

   initial
     begin
	$dumpfile("signal_multi_xor.vcd");
        $dumpvars;
        $display("\t\ttime, \te1, \tout");
        $monitor("%d \t%b\t%b", $time, e1, out);

	e1 <= 0;
	#20;
	e1 <= 1;
	#20;
	e1 <= 2;
	#20;
	e1 <= 3;
	#20;
	e1 <= 4;
	#20;
	e1 <= 5;
	#20;
	e1 <= 6;
	#20;
	e1 <= 7;
	#20;
     end
endmodule
