.include "I_imm.v"
.include "S_imm.v"
.include "B_imm.v"

module spliter(instr
	       opcode,
	       rd, rs1, rs2,
	       funct3, funct7,
	       I_imm, S_imm, B_imm, U_imm, J_imm);

   input [31:0] instr;
   output [6:0]	opcode;

   output [4:0]	rd;
   output [4:0]	rs1;
   output [4:0]	rs2;

   output [2:0]	funct3;
   output [6:0]	funct7;

   output [31:0] I_imm;
   output [31:0] S_imm;
   output [31:0] B_imm;
   output [31:0] U_imm;
   output [31:0] J_imm;

   assign opcode = instr[6:0];
   assign rd = instr[11:7];
   assign funct3 = instr[14:12];
   assign rs1 = instr[19:15];
   assign rs2 = instr[24:20];
   assign funct7 = instr[31:25];

   I_imm I_imm(instr[31:20], I_imm);
   S_imm S_imm(instr[11: 7], instr[31:25], S_imm);
   B_imm B_imm(instr[11: 8], instr[30:25], instr[7], instr[31], B_imm);
endmodule
