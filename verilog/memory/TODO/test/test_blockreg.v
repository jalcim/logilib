module test_blockreg;
   reg clk, reset, charge;
   reg [1:0] addr_reg, outA, outB;
   reg [7:0] datain;

   wire [7:0] dataoutA, dataoutB;
   wire       error;

   blockreg blockreg(clk, reset, charge, addr_reg, outA, outB, datain, dataoutA, dataoutB, error);

   initial
     begin
	$dumpfile("build/memory/signal/signal_blockreg.vcd");
	$dumpvars;
	$display("\t\ttime, \tclk, \treset, \tcharge, \taddr_reg, \toutA, \toutB, \tdatain, \tdataoutA, \tdataoutB, \terror);");
	$monitor("%d \t%b \t%b \t%b \t\t%d \t\t%d \t%d \t%d \t\t%d \t\t%d \t\t%d",
		 $time, clk, reset, charge, addr_reg, outA, outB, datain, dataoutA, dataoutB, error);

	clk = 0;
	reset = 1;
	charge = 0;
	outA = 0;
	outB = 0;
	addr_reg = 0;
	datain = 0;
	#100;
	reset = 0;
	datain = 7;
	addr_reg = 2;
	charge = 1;
	#100;
	clk = 1;
	#100;
	clk = 0;
	charge = 0;
	outA = 2;
	addr_reg = 0;
	datain = 0;
	#100;
	clk = 1;
	#100;
	clk = 0;
     end
endmodule // test_blockreg
