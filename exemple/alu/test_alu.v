`include "exemple/alu/alu.v"

module test_alu;
   reg [31:0] datain_A, datain_B;
   reg [2 :0] funct3;
   reg funct7;
   wire	[31:0] out;

   alu alu_inst(datain_A, datain_B, funct3, funct7, out);

   initial
     begin
	$dumpfile("signal_alu.vcd");
	$dumpvars;
	$display("\t\ttime, \t\tA, \t\tB, \tfunct3, \tfunct7, \tout");
	$monitor("%d \t%d \t%d \t%b \t\t%b \t%d\n",
		 $time, datain_A, datain_B, funct3, funct7, out);

	$display("add 0+0");
	datain_A <= 0;
	datain_B <= 0;
	funct3 <= 0;
	funct7 <= 0;
	#100;

	$display("add 22+13");
	datain_A <= 22;
	datain_B <= 13;
	#100;

	$display("sub 20-13");
	datain_A <= 20;
	datain_B <= 13;
	funct7 <= 1;
	#100;

	$display("sll 4 1");
	datain_A <= 4;
	datain_B <= 1;
	funct7 <= 0;
	funct3 <= 1;
	#100;

	$display("slt 4 1");
	datain_A <= 4;
	datain_B <= 1;
	funct3 <= 2;
	#100;

	$display("slt 1 4");
	datain_A <= 1;
	datain_B <= 4;
	#100;

	$display("slt 4 4");
	datain_A <= 4;
	datain_B <= 4;
	#100;

	$display("slt -4 1");
	datain_A <= -4;
	datain_B <= 1;
	#100;

	$display("slt 1 -4");
	datain_A <= 1;
	datain_B <= -4;
	#100;

	$display("slt -4 -4");
	datain_A <= -4;
	datain_B <= -4;
	#100;

	$display("sltu 4 1");
	datain_A <= 4;
	datain_B <= 1;
	funct3 <= 3;
	#100;

	$display("sltu 1 4");
	datain_A <= 1;
	datain_B <= 4;
	#100;

	$display("sltu 4 4");
	datain_A <= 4;
	datain_B <= 4;
	#100;

	$display("xor 7 5");
	datain_A <= 7;
	datain_B <= 5;
	funct3 <= 4;
	#100;

	$display("xor 4 4");
	datain_A <= 4;
	datain_B <= 1;
	#100;

	$display("srl 7 1");
	datain_A <= 7;
	datain_B <= 1;
	funct3 <= 5;
	#100;

	$display("srl 7 2");
	datain_A <= 7;
	datain_B <= 2;
	#100;

	$display("or 4 3");
	datain_A <= 4;
	datain_B <= 3;
	funct3 <= 6;
	#100;

	$display("or 2 3");
	datain_A <= 2;
	datain_B <= 4;
	#100;

	$display("and 5 3");
	datain_A <= 5;
	datain_B <= 3;
	funct3 <= 7;
	#100;

     end
endmodule
