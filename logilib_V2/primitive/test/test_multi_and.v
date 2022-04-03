module _test_multi_and;
   parameter SIZE = 6;

   reg [SIZE-1:0] e1;
   wire out;

   multi_and #(.SIZE(SIZE)) test_multi_and(out, e1);

   initial
     begin
	$dumpfile("signal_JKlatchUP.vcd");
        $dumpvars;
        $display("\t\ttime, \te1, \tout");
        $monitor("%d \t%b\t%b", $time, e1, out);

	e1 = 0;
	#100;
	e1 = 63;
	#100;
	e1 = 3;
     end
endmodule
