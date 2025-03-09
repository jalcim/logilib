`include "exemple/jal_jalr/jal/jal.v"
`include "exemple/jal_jalr/jalr/jalr.v"

module jal_jalr(input [31:0] pc_in,
		input [31:0] imm,
		input [31:0] rs1,
		input signal_jalr,

		output signal_pc,
		output [31:0] pc_out,
		output [31:0] ret);

   wire	[31:0]		      jal_out;
   wire	[31:0]		      jalr_out;

   wire [31:0]		      jal_ret;
   wire	[31:0]		      jalr_ret;

   jal jal_inst(.pc(pc_in),
		.imm_j(imm),
		.jal_out(jal_out),
		.ret(jal_ret));

   jalr jalr_inst(.rs1(rs1),
		  .imm_i(imm),
		  .jal_out(jalr_out),
		  .ret(jalr_ret));

   assign signal_pc = signal_jalr;
   assign pc_out = signal_jalr ? jalr_out : jal_out;

   assign ret = signal_jalr ? jalr_ret : jal_ret;

endmodule
