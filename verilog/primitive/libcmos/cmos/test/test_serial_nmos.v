module test_serial_nmos;
   parameter SIZE = 10;
   wire drain;
   reg gate;
   supply0 source;
   integer sim_counter;

   serial_nmos #(.SIZE(SIZE)) serial_nmos_inst(drain, source,
					       {SIZE{gate}});

   initial
     begin
	$dumpfile("signal_test_serial_nmos.vcd");
        $dumpvars;
        $display("\t\ttime, \tD, \tG, \tS");
        $monitor("%d \t%b\t%b\t%b", $time, drain, source, gate);

	sim_counter = 0;
	while (sim_counter < SIZE)
	  begin
	     gate <= 0;
	     #100;
	     gate <= 1;
	     #100;
	  end
     end
endmodule
