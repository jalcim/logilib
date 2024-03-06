`include "exemple/write_back/write_back.v"

module test_write_back;
   reg clk, reset, write_rd_in;
   reg [4:0] rd_in;
   reg [31:0]	alu, lui_auipc, jal_jalr, lsu;
   reg	signal_lui, signal_auipc, signal_jal, signal_jalr, signal_load;

   wire	write_rd_out;
   wire [4:0] rd_out;
   wire [31:0] dataout;

   write_back write_back_inst(clk, reset, write_rd_in, rd_in,
			      alu, lui_auipc, jal_jalr, lsu,
			      signal_lui, signal_auipc, signal_jal, signal_jalr, signal_load,
			      write_rd_out, rd_out, dataout);

   initial
     begin
	$dumpfile("signal_write_back.vcd");
	$dumpvars;
	$monitor("time = %d \nclk = %b \nreset = %b \nwrite_rd_in = %b \nrd_in = %b \nalu = %d \nlui_auipc = %d \njal_jalr = %d \nlsu = %d \nsignal_lui = %b \nsignal_auipc = %b \nsignal_jal = %b \nsignal_jalr = %b \nsignal_load = %b \nwrite_rd_out = %b \nrd_out = %b \ndataout = %b\n\n\n\n",
		 $time, clk, reset, write_rd_in, rd_in,
		 alu, lui_auipc, jal_jalr, lsu,
		 signal_lui, signal_auipc, signal_jal, signal_jalr, signal_load,
		 write_rd_out, rd_out, dataout);

	clk <= 0;
	reset <=1;
	write_rd_in <= 0;
	rd_in <= 0;

	alu <= $urandom;
	lui_auipc <= $urandom;
	jal_jalr <= $urandom;
	lsu <= $urandom;

	signal_lui <= 0;
	signal_auipc <= 0;
	signal_jal <= 0;
	signal_jalr <= 0;
	signal_load <= 0;
	#5;
	clk <= 1;
	#5;
	clk <= 0;
	
     end
endmodule
