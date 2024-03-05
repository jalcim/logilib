`include "exemple/pc/pc.v"

module test_pc;
   reg clk;
   reg pc_reset;
   reg signal_pc;
   reg [31:0] pc_next;

   wire [31:0] pc_out;

   pc pc_inst(clk, signal_pc, pc_reset, pc_next, pc_out);

   initial
     begin
	$dumpfile("signal_pc.vcd");
	$dumpvars;
	$display("\t\ttime, \tclk, \tpc_reset, \tsignal_pc, \tpc_next, \tpc_out");
	$monitor("%d \t%b \t%b \t\t%b \t%d \t%d\n",
		 $time, clk, pc_reset, signal_pc, pc_next, pc_out);

	clk <= 0;
	pc_reset <= 1;
	signal_pc <= 0;
	pc_next <= 1000;
	#5;
	pc_reset <= 0;
	#5;
	clk <= 1;
	#5;
	clk <= 0;
	#5;
	clk <= 1;
	#5;
	clk <= 0;
	pc_reset <= 1;
	#5;
	clk <= 1;
	pc_reset <= 0;
	signal_pc <= 1;
	#5;
	clk <= 0;
	
     end
endmodule
