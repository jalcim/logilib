module test_parallel_nmos;
   parameter SIZE = 10;
   wire    drain;
   supply0 source;
   reg 	   gate;
   integer sim_counter;

   t_nmos inst(drain, source, gate);

   initial
     begin
	$dumpfile("signal_test_parallel_nmos.vcd");
        $dumpvars;
        $display("\t\ttime, \tD, \tS, \tG");
        $monitor("%d \t%b\t%b\t%b", $time, drain, source, gate);

	sim_counter = 0;
	while (sim_counter < SIZE)
	  begin
	     gate[sim_counter] <= 0;
	     sim_counter++;
	  end
	#100;
     end
endmodule
