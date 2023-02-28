module test_serial_pmos;
   parameter SIZE = 10;
   wire drain;
   reg gate;
   supply1 source;
   integer sim_counter;

   serial_pmos #(.SIZE(SIZE)) serial_pmos_inst(drain, {SIZE{gate}}, source);

   initial
     begin
	$dumpfile("signal_test_serial_pmos.vcd");
        $dumpvars;
        $display("\t\ttime, \tD, \tG, \tS");
        $monitor("%d \t%b\t%b\t%b", $time, drain, gate, source);

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
