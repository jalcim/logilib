module test_regdec;

   reg [7:0] a;
   reg 	     rl;
   wire [7:0] s;
   
   regdec regdec_test(a, rl, s);

   
   initial
     begin
	$dumpfile("build/memory/signal/signal_or.vcd");
	$dumpvars;
        $display("\t\ttime,\ta,\tb, \ts");
	$monitor("%d \t%d \t%b \t%d", $time, a, rl, s);

	a = 16;
	rl = 1;
	#5;
	a = 16;
	rl = 0;	
     end
   
   
endmodule // test_regdec
