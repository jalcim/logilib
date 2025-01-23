`include "exemple/block_reg/block_reg.v"

module test_block_reg;
   parameter SIZE_ADDR_REG = 5;
   parameter SIZE_REG = 8;

   reg	     clk, reset, write_rd;
   reg [SIZE_ADDR_REG-1:0] rd, rs1, rs2;
   reg [SIZE_REG-1:0] datain;

   wire [SIZE_REG-1:0] out_rs1, out_rs2;

   block_reg #(.SIZE_ADDR_REG(SIZE_ADDR_REG), .SIZE_REG(SIZE_REG))block_reg(clk, reset, write_rd,
									    rd, rs1, rs2,
									    datain,
									    out_rs1, out_rs2);

   initial
     begin
	$dumpfile("signal_block_reg.vcd");
	$dumpvars;
	$display("\t\ttime, \tclk, \treset, \twrite_rd, \trd, \t\t\trs1, \trs2, \tdatain, \tout_rs1, \tout_rs2\n");
	$monitor("%d \t%b \t%b \t%b \t\t%d \t\t\t%d \t%d \t%d \t\t%d \t\t%d \n",
		 $time, clk, reset, write_rd, rd, rs1, rs2, datain, out_rs1, out_rs2);

	$display("init");
	clk = 0;
	reset = 1;
	write_rd = 0;
	rs1 = 0;
	rs2 = 0;
	rd = 0;
	datain = 0;
	#100;

	$display("on prepare la write_rd mais pas de clk");
	reset = 0;
	datain = 7;
	rd = 2;
	write_rd = 1;
	rs1 = 2;
	#100;

	$display("on write_rd 7 dans 2");
	clk = 1;
	#100;

	$display("on enleve les signaux");
	clk = 0;
	write_rd = 0;
	rd = 0;
	datain = 0;
	#100;
	
	$display("on clk");
	clk = 1;
	#100;
	
	$display ("enleve clk");
	clk = 0;
	#100;

	$display("write_rd sans clk");
	write_rd = 1;
	#100;

	$display("clk sans write_rd");
	clk = 1;
	write_rd = 0;
	#100;

	$display("write_rd 0 dans 2");
	clk = 1;
	write_rd = 1;
	rd = 2;
	#100;

	$display ("enleve clk");
	clk = 0;
	#100

	$display("write_rd 250 dans 2");
	clk = 1;
	write_rd = 1;
	rd = 2;
	datain = 250;
	#100;

	$display ("enleve clk");
	clk <= 0;
	#100

	$display("write_rd 124 dans 30");
	clk = 1;
	write_rd = 1;
	rd = 30;
	datain = 124;
	rs2 = 30;
	#100;

     end
endmodule
