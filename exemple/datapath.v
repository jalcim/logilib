`include "pc/pc.v"
`include "rom/rom.v"
`include "decodeur/decodeur.v"
`include "block_reg/block_reg.v"

module riscv_datapath(input reset,
		      input active,
		      input extern_clk);

   wire			    clk;
   assign clk = extern_clk & active;
   pc pc_inst(clk, signal_pc, reset, pc_next, pc_out);
   wire [31:0]		    pc_out;

   //////////////////////////////////////////////////
   
   rom rom (pc, opcode);
   wire [31:0]		    opcode;

   //////////////////////////////////////////////////

   decodeur decodeur (instr,

		      imm,
		      write_rd,
		      
		      opcode,

		      rd,
		      rs1,
		      rs2,

		      funct3,
		      funct7,

		      OP_IMM,
		      LUI,
		      AUIPC,
		      OP,
		      JAL,
		      JALR,
		      BRANCH,
		      LOAD,
		      STORE,
		      MISC_MEM,
		      SYSTEM);

   wire [6:0]		    opcode;

   wire [4:0]		    rd;
   wire [4:0]		    rs1;
   wire [4:0]		    rs2;
   wire [2:0]		    funct3;
   wire [6:0]		    funct7;

   wire [31:0]		    imm;
   wire			    write_rd;

   wire			    OP_IMM;
   wire			    LUI;
   wire			    AUIPC;
   wire			    OP;
   wire			    JAL;
   wire			    JALR;
   wire			    BRANCH;
   wire			    LOAD;
   wire			    STORE;
   wire			    MISC_MEM;
   wire			    SYSTEM;

   //////////////////////////////////////////////////

   block_reg #(.SIZE_ADDR_REG(SIZE_ADDR_REG), .SIZE_REG(SIZE_REG))block_reg(clk, reset, write_rd,
									    rd, rs1, rs2,
									    datain,
									    out_rs1, out_rs2);
   wire [SIZE_REG-1:0]	    out_rs1, out_rs2;

   //////////////////////////////////////////////////

   alu_primary alu_inst(out_rs1, out_rs2,
			funct3, funct7,
			BRANCH, pc_out, imm,
			SIGNAL_pc, data);

   wire			    SIGNAL_pc;
   wire [31:0]		    data;

   //////////////////////////////////////////////////

endmodule
