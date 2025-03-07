`include "exemple/auipc_lui/auipc/auipc.v"
`include "exemple/auipc_lui/lui/lui.v"

module auipc_lui(
		 input [31:0]  imm_u,
		 input [31:0]  pc,
		 input signal_auipc,
		 output [31:0] data
		 );

   wire [31:0]		       lui_out;
   wire [31:0]		       auipc_out;

   lui lui_inst(imm_u, lui_out);
   auipc auipc_inst(imm_u, pc, auipc_out);

   assign data = signal_auipc ? auipc_out : lui_out;

endmodule
