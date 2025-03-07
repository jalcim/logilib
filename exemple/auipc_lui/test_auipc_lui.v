`include "exemple/auipc_lui/auipc_lui.v"

module test_auipc_lui;
   reg [31:0] imm_u;
   reg [31:0] pc;
   reg	      signal_auipc;
   wire [31:0] data;

   auipc_lui auipc_lui_inst(imm_u, pc, signal_auipc, data);

   initial
     begin
	$dumpfile("signal_auipc_lui.vcd");
	$dumpvars;
	$display("\t\ttime, \timm, \tpc \tsignal_auipc \ttdata");
	$monitor("%d \t%b \t%b \t%b \t%b", $time, imm_u, pc, signal_auipc, data);

	imm_u = 0;
	pc = 0;
	signal_auipc = 0;
	#100;
	imm_u <= 32;
	pc <= 16;
	signal_auipc <= 0;
	#100;
	imm_u <= 16;
	pc <= 8;
	signal_auipc <= 1;
	#100;
	imm_u <= 4;
	pc <= 8;
	signal_auipc <= 0;
	#100;
	imm_u <= 16;
	pc <= 8;
	signal_auipc <= 1;
	#100;
     end
endmodule
