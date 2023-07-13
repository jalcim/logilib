module test_memory;
   reg write, read, clk, reset, activate;
   reg [3:0] addrin, addrout;
   reg [7:0] datain;

   wire [7:0] dataout;
   wire       error;

   memory memory(write, read, clk, reset, activate, addrin,
		 addrout, datain, dataout, error);

   initial
     begin
	$dumpfile("build/memory/signal/signal_memory.vcd");
	$dumpvars;
	$display("\t\ttime, \twrite, \tread, \tclk, \treset, \tactivate, \taddrin, \taddrout, \tdatain, \tdataout, \terror");
		$monitor("%d \t%b \t%b \t%b \t%b \t%d \t\t%d \t\t%d \t\t%d \t\t%b \t%d", $time, write, read, clk, reset, activate,
		 addrin[3:0], addrout[3:0], datain[7:0], dataout[7:0], error);
	
	clk = 0;
	reset = 1;
	write = 0;
	read = 0;
	activate = 0;
	addrin = 0;
	addrout = 0;
	datain = 0;
	#100;
	reset = 0;
	activate = 1;
	write = 1;
	read = 0;
	addrin = 4;
	addrout = 0;
	datain = 7;
	#100;
	clk = 1;
	#100;
	clk = 0;
	#100;
	write = 0;
	read = 1;
	addrin = 0;
	addrout = 4;
	datain = 0;
	#100;
	clk = 1;
	#100;
	clk = 0;
	#100;
     end // initial begin

endmodule // test_memory
