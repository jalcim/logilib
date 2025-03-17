`include "exemple/pc/pc.v"
`include "exemple/rom/rom.v"
`include "exemple/decodeur/decodeur.v"
`include "exemple/block_reg/block_reg.v"
`include "exemple/alu/alu.v"
`include "exemple/lsu/lsu.v"
`include "exemple/auipc_lui/auipc_lui.v"
`include "exemple/jal_jalr/jal_jalr.v"
`include "exemple/write_back/write_back.v"

module riscv_datapath(input reset,
		      input active,
		      input extern_clk);

   parameter		    SIZE_ADDR_REG = 32;
   parameter		    SIZE_REG = 32;

   wire			    clk;
   assign clk = extern_clk & active;

   //////////////////////////////////////////////////

   pc pc_inst(clk, signal_pc, reset, pc_next, pc_out);
   wire [31:0]		    pc_out;

   //////////////////////////////////////////////////
   
   rom rom (pc_out, instr);
   wire [31:0]		    instr;

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

   wire [4:0]		    rd;
   wire [4:0]		    rs1;
   wire [4:0]		    rs2;
   wire [2:0]		    funct3;
   wire [6:0]		    funct7;
   wire [6:0]		    opcode;

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

   block_reg #(.SIZE_ADDR_REG(5), .SIZE_REG(SIZE_REG))
   block_reg (clk, reset, write_rd,
	      rd, rs1, rs2,
	      dataout,
	      out_rs1, out_rs2);

   wire [SIZE_REG-1:0]	    out_rs1, out_rs2;

   //////////////////////////////////////////////////

   alu_primary alu_inst(out_rs1, out_rs2,
			funct3, funct7,
			BRANCH, SIGNAL_pc,
			pc_out, imm, alu_data);

   wire			    SIGNAL_pc;
   wire [31:0]		    alu_data;

   //////////////////////////////////////////////////

   lsu #(.SIZE_ADDR_MEM(SIZE_ADDR_REG),
	 .SIZE_MEM(SIZE_REG))
   lsu_inst(out_rs1, out_rs2,
	    imm, funct3,
	    STORE, clk,
	    lsu_data);

   wire [31:0]		    lsu_data;

   //////////////////////////////////////////////////

   auipc_lui auipc_lui_inst(imm, pc_out, AUIPC, auipc_lui_data);

   wire [31:0]		    auipc_lui_data;

   //////////////////////////////////////////////////

   jal_jalr jal_jalr_inst (.pc_in(pc_out),
			   .imm(imm),
			   .rs1(out_rs1),
			   .signal_jalr(JALR),

			   .signal_pc(signal_pc),
			   .pc_out(jal_jalr_next_pc),
			   .ret(jal_jalr_data)
			   );
   wire			    signal_pc;
   wire [31:0]		    jal_jalr_next_pc;
   wire [31:0]		    jal_jalr_data;

   //////////////////////////////////////////////////

   write_back write_back_inst(.clk(clk),
			      .reset(reset),
			      .write_rd_in(write_rd),
			      .rd_in(rd),
			      .alu(alu_data),
			      .lui_auipc(auipc_lui_data),
			      .jal_jalr(jal_jalr_data),
			      .lsu(lsu_data),
			      .signal_lui(LUI),
			      .signal_auipc(AUIPC),
			      .signal_jal(JAL),
			      .signal_jalr(JALR),
			      .signal_load(LOAD),
			      .jal_jalr_pc(pc_next),
			      .write_rd_out(write_rd_out),
			      .rd_out(rd_out),
			      .dataout(dataout));

   wire [31:0]		    pc_next;
   wire			    write_rd_out;
   wire [4:0]		    rd_out;
   wire [31:0]		    dataout;

endmodule
