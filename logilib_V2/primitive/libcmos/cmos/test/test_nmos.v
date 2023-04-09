module test_parallel_nmos;
   wire    drain;
   supply0 source;
   reg 	   gate;

   t_nmos inst(drain, source, gate);

   initial
     begin
	$dumpfile("signal_test_parallel_nmos.vcd");
        $dumpvars;
        $display("\t\ttime, \tD, \tS, \tG");
        $monitor("%d \t%b\t%b\t%b", $time, drain, source, gate);

	gate <= 0;
	#100;
	gate <= 1;
	#100;
     end
endmodule
