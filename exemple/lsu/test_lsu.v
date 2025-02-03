`include "exemple/lsu/lsu.v"

module test_lsu;
   reg [31:0] rs1;
   reg [31:0] rs2;
   reg [31:0] imm_S;
   reg [2:0]  funct3;
   reg	      signal_store;
   reg	      clk;

   wire [31:0] data;

   lsu lsu_inst(rs1, rs2,
		imm_S, funct3,
		signal_store, clk,
		data);

   initial
     begin
	clk = 0;
	rs1 = 0;
	rs2 = 0;
	imm_S = 0;
	funct3 = 0;
	signal_store = 0;
	$display("data = %d", data);

	#100 clk <= 1;
	#100 clk <= 0;
	$display("data = %d", data);

//	imm_S <= 0xffffffff;
	#100;
     end
endmodule
