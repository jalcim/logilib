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

     end
endmodule
