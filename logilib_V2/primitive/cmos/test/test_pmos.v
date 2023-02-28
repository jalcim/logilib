module test_parallel_pmos;
   wire    drain;
   supply1 source;
   reg 	   gate;

   t_pmos inst(drain, source, gate);

   initial
     begin
	$dumpfile("signal_test_parallel_pmos.vcd");
        $dumpvars;
        $display("\t\ttime, \tD, \tS, \tG");
        $monitor("%d \t%b\t%b\t%b", $time, drain, source, gate);

	gate <= 0;
	#100;
	gate <= 1;
	#100;
     end
endmodule
