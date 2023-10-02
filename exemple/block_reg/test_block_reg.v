`include "exemple/block_reg/block_reg.v"

module test_block_reg;
   parameter SIZE_ADDR_REG = 5;
   parameter SIZE_REG = 8;

   reg	     clk, reset, charge;
   reg [SIZE_ADDR_REG-1:0] addr_write_reg, outA, outB;
   reg [SIZE_REG-1:0] datain;

   wire [SIZE_REG-1:0] dataoutA, dataoutB;

   block_reg #(.SIZE_ADDR_REG(SIZE_ADDR_REG), .SIZE_REG(SIZE_REG))block_reg(clk, reset, charge,
									  addr_write_reg, outA, outB,
									  datain,
									  dataoutA, dataoutB);

   initial
     begin
	$dumpfile("signal_block_reg.vcd");
	$dumpvars;
	$display("\t\ttime, \tclk, \treset, \tcharge, \taddr_write_reg, \toutA, \toutB, \tdatain, \tdataoutA, \tdataoutB\n");
	$monitor("%d \t%b \t%b \t%b \t\t%d \t\t\t%d \t%d \t%d \t\t%d \t\t%d \n",
		 $time, clk, reset, charge, addr_write_reg, outA, outB, datain, dataoutA, dataoutB);

	$display("init");
	clk = 0;
	reset = 1;
	charge = 0;
	outA = 0;
	outB = 0;
	addr_write_reg = 0;
	datain = 0;
	#100;

	$display("on prepare la charge mais pas de clk");
	reset = 0;
	datain = 7;
	addr_write_reg = 2;
	charge = 1;
	outA = 2;
	#100;

	$display("on charge 7 dans 2");
	clk = 1;
	#100;

	$display("on enleve les signaux");
	clk = 0;
	charge = 0;
	addr_write_reg = 0;
	datain = 0;
	#100;
	
	$display("on clk");
	clk = 1;
	#100;
	
	$display ("enleve clk");
	clk = 0;
	#100;

	$display("charge sans clk");
	charge = 1;
	#100;

	$display("clk sans charge");
	clk = 1;
	charge = 0;
	#100;

	$display("charge 0 dans 2");
	clk = 1;
	charge = 1;
	addr_write_reg = 2;
	#100;

	$display ("enleve clk");
	clk = 0;
	#100

	$display("charge 250 dans 2");
	clk = 1;
	charge = 1;
	addr_write_reg = 2;
	datain = 250;
	#100;

	$display ("enleve clk");
	clk <= 0;
	#100

	$display("charge 124 dans 30");
	clk = 1;
	charge = 1;
	addr_write_reg = 30;
	datain = 124;
	outB = 30;
	#100;

     end
endmodule
