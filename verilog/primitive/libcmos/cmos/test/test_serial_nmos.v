module test_serial_nmos;
   parameter SIZE = 10;
   wire drain;
   reg [SIZE-1:0] gate;
   supply0 source;
   integer sim_counter;

   serial_nmos #(.SIZE(SIZE)) serial_nmos_inst(drain, source, gate);

   initial
     begin
	$dumpfile("signal_test_serial_nmos.vcd");
        $dumpvars;
        $display("\t\ttime, \tD, \tG, \tS");
        $monitor("%d \t%b\t%b\t%b", $time, drain, source, gate);

	sim_counter = 0;
	while (sim_counter < 2**SIZE)
	  begin
	     gate <= sim_counter;
	     #100;
	     sim_counter <= sim_counter + 1;
	  end
     end
endmodule
