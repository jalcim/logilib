`include "exemple/decodeur/spliter/imm/I_imm_decoder.v"
`include "exemple/decodeur/spliter/imm/S_imm_decoder.v"
`include "exemple/decodeur/spliter/imm/B_imm_decoder.v"
`include "exemple/decodeur/spliter/imm/U_imm_decoder.v"
`include "exemple/decodeur/spliter/imm/J_imm_decoder.v"

module spliter(input [31:0] instr,
	       output [6:0]  opcode,

	       output [4:0]  rd,
	       output [4:0]  rs1,
	       output [4:0]  rs2,

	       output [2:0]  funct3,
	       output [6:0]  funct7,

	       output [31:0] I_imm,
	       output [31:0] S_imm,
	       output [31:0] B_imm,
	       output [31:0] U_imm,
	       output [31:0] J_imm);

   assign opcode = instr[6:0];
   assign rd = instr[11:7];
   assign funct3 = instr[14:12];
   assign rs1 = instr[19:15];
   assign rs2 = instr[24:20];
   assign funct7 = instr[31:25];

   I_imm_decoder I_imm_decoder(.imm11_0(instr[31:20]),
			       .I_imm(I_imm));

   S_imm_decoder S_imm_decoder(.imm4_0(instr[11: 7]),
			       .imm11_5(instr[31:25]),
			       .S_imm(S_imm));

   B_imm_decoder B_imm_decoder(.imm12(instr[31]),
			       .imm11(instr[7]),
			       .imm10_5(instr[30:25]),
			       .imm4_1(instr[11: 8]),
			       .B_imm(B_imm));

   U_imm_decoder U_imm_decoder(.imm31_12(instr[31:12]),
			       .U_imm(U_imm));

   J_imm_decoder J_imm_decoder(.imm20(instr[31]),
			       .imm19_12(instr[19:12]),
			       .imm11(instr[20]),
			       .imm10_1(instr[30:21]),
			       .J_imm(J_imm));
endmodule
