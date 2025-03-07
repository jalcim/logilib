`include "exemple/auipc_lui/lui/lui.v"

module test_lui;
   reg [31:0] imm_u;
   wire [31:0] out;

   lui lui_inst(imm_u, out);

   initial
     begin
	$dumpfile("signal_lui.vcd");
	$dumpvars;
	$display("\t\ttime, \timm, \t\t\t\t\tout");
	$monitor("%d \t%b \t%b", $time, imm_u, out);

	imm_u = 0;
	#100;
	imm_u <= 1;
	#100;
	imm_u <= 4;
	#100;
	imm_u <= 16;
	#100;
	imm_u <= 32;
	#100;
	imm_u <= 64;
	#100;
	imm_u <= 128;
	#100;
     end
endmodule
