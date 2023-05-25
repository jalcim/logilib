module test_serial_pmos;
   parameter SIZE = 10;
   wire drain;
   reg [SIZE-1:0] gate;
   supply1 source;
   integer sim_counter;

   serial_pmos #(.SIZE(SIZE)) serial_pmos_inst(drain, source, gate);

   initial
     begin
	$dumpfile("signal_test_serial_pmos.vcd");
        $dumpvars;
        $display("\t\ttime, \tD, \tG, \t\tS");
        $monitor("%d \t%b\t%b\t%b", $time, drain, gate, source);

	sim_counter = 0;
	while (sim_counter < 2**SIZE)
	  begin
	     gate <= sim_counter;
	     #100;
	     sim_counter <= sim_counter + 1;
	  end
     end
endmodule
