`include "spliter/spliter.v"
`include "opcode/opcode.v"

module decodeur (input [31:0] instr,
		 output [31:0] imm,
		 output write_rd,
		 output OP_IMM,
		 output LUI,
		 output AUIPC,
		 output OP,
		 output JAL,
		 output JALR,
		 output BRANCH,
		 output LOAD,
		 output STORE,
		 output MISC_MEM,
		 output SYSTEM);

   wire [6:0]		opcode;

   wire [4:0]		rd;
   wire [4:0]		rs1;
   wire [4:0]		rs2;

   wire [2:0]		funct3;
   wire [6:0]		funct7;

   wire [31:0]		I_imm;
   wire [31:0]		S_imm;
   wire [31:0]		B_imm;
   wire [31:0]		U_imm;
   wire [31:0]		J_imm;

   spliter spliter(instr, opcode,
		   rd, rs1, rs2,
		   funct3, funct7,
		   I_imm, S_imm, B_imm, U_imm, J_imm);

   OPCODE OPCODE(opcode,
		 {SYSTEM, MISC_MEM, STORE, LOAD, BRANCH,
		  JALR, JAL, OP, AUIPC, LUI, OP_IMM});

   wire			or1, or2;

   assign or1 = (OP_IMM | JALR | LOAD);
   assign or2 = (LUI | AUIPC);
   assign write_rd = or1 | or2 | JAL | OP;

   assign imm = or1    ? I_imm :
		or2    ? U_imm :
		JAL    ? J_imm :
		BRANCH ? B_imm :
		STORE  ? S_imm : 0;

endmodule
