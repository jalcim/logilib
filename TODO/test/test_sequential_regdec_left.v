module test_sequential_regdec_left;
   reg [2:0] sequenceur;
   reg [7:0] bus_in;
   reg 	     clk, reset;
   wire [7:0] bus_out;
   supply0   masse;

   sequential_regdec_left tester(sequenceur, bus_in, masse, clk, reset, bus_out);
   initial
     begin
	$dumpfile("build/memory/signal/signal_test_sequential_regdec.vcd");
	$dumpvars;
	$display("\t\ttime,\tsequenceur,\tbus_in,\t\tclk,\treset,\tbus_out");
	$monitor("%d\t%d\t\t%d\t\t%b\t%d\t%d", $time, sequenceur, bus_in[7:0], clk, reset, bus_out[7:0]);
	sequenceur = 0;
	bus_in = 127;
	clk = 0;
	reset = 1;
	#100;
	reset = 0;
	clk = 1;
	#100;
	clk = 0;
	sequenceur = 1;
	#100;
	clk = 1;
	#100;
	clk = 0;
	sequenceur = 2;
	#100;
	clk = 1;
	#100;
	clk = 0;
	sequenceur = 3;
	#100;
	clk = 1;
	#100;
	clk = 0;
     end
endmodule // test_sequential_regdec
