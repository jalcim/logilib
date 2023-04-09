module test_parallel_nmos;
   parameter SIZE = 10;
   wire [SIZE-1:0] drain;
   supply0	   source;
   reg [SIZE-1:0]  gate;
   integer 	   sim_counter;

   parallel_nmos #(.SIZE(SIZE)) parallel_nmos_inst(drain,
						   {SIZE{source}},
						   gate);

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
	sim_counter = 0;
	while (sim_counter < SIZE)
	  begin
	     gate[sim_counter] <= 1;
	     #100;
	     sim_counter++;
	  end
     end
endmodule
