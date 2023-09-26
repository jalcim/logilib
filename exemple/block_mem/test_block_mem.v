`include "exemple/block_mem/block_mem.v"

module test_block_mem;
   parameter SIZE_ADDR_MEM = 5;
   parameter SIZE_MEM = 8;

   reg clk, reset, signal_write;
   reg [SIZE_ADDR_MEM-1:0] addrin, addrout;
   reg [SIZE_MEM-1:0] datain;

   wire [SIZE_MEM-1:0] dataout;

   block_mem #(.SIZE_ADDR_MEM(SIZE_ADDR_MEM), .SIZE_MEM(SIZE_MEM)) block_mem_inst(clk,
										  reset,
										  signal_write,
										  addrin,
										  addrout,
										  datain,
										  dataout);
   initial
     begin
	$dumpfile("signal_block_mem.vcd");
	$dumpvars;
	$display("\t\ttime, \tclk, \treset, \tsignal_write, \taddrin, \taddrout, \tdatain, \tdataout");
	$monitor("%d \t%b \t%b \t%b \t\t%d \t\t%d \t\t%d \t\t%d\n",
		 $time, clk, reset, signal_write, addrin, addrout, datain, dataout);

	$display("init");
	clk <= 0;
	reset <= 1;
	signal_write <= 0;
	addrin <= 0;
	addrout <= 0;
	datain <= 0;
	#100;

	$display("write");
	clk <= 1;
	reset <= 0;
	signal_write <= 1;
	addrin <= 0;
	addrout <= 0;
	datain <= 15;
	#100;

	$display("read");
	clk <= 0;
	reset <= 0;
	signal_write <= 0;
	addrin <= 0;
	addrout <= 0;
	datain <= 0;
	#100;
     end

endmodule
