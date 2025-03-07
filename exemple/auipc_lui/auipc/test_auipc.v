`include "exemple/auipc_lui/auipc/auipc.v"

module test_auipc;
   reg [31:0] imm_u;
   reg [31:0] pc;
   wire [31:0] out;

   auipc auipc_inst(imm_u, pc, out);

   initial
     begin
	$dumpfile("signal_auipc.vcd");
	$dumpvars;
	$display("\t\ttime, \timm, \t\t\t\t\tpc \t\t\t\t\tout");
	$monitor("%d \t%b \t%b \t%b", $time, imm_u, pc, out);

	imm_u = 0;
	pc = 0;
	#100;
	imm_u <= 1;
	pc <= 32;
	#100;
	imm_u <= 4;
	pc <= 16;
	#100;
	imm_u <= 16;
	pc <= 64;
	#100;
	imm_u <= 32;
	pc <= 1;
	#100;
	imm_u <= 64;
	pc <= 4;
	#100;
	imm_u <= 128;
	pc <= 8;
	#100;
     end
endmodule
