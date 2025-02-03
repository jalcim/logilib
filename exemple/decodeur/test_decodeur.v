`include "exemple/decodeur/decodeur.v"

module test_decodeur;
   reg	      clk;
   reg [7:0]	mem1, mem2, mem3, mem4;
   wire [31:0]	      instr;

   integer	      fd;
   integer	      code;

   wire [10:0]	      operation;

   assign instr = {mem4, mem3, mem2, mem1};

   assign operation = {SYSTEM, MISC_MEM, STORE, LOAD, BRANCH,
		       JALR, JAL, OP, AUIPC, LUI, OP_IMM};

   initial
     begin
	$dumpfile("test_decodeur.vcd");
	$dumpvars;
	$display("\t\ttime, \tmem, \t\t\t\t\timm, \t\twrite_rd, \toperation");
	$monitor("%d \t%b \t%x \t%b \t\t%b", $time, instr, imm, write_rd, operation);
	mem1 = 0;
	mem2 = 0;
	mem3 = 0;
	mem4 = 0;
	clk = 0;
	fd = $fopen("binary.raw", "r");
     end

   always
     #100 clk = ~clk;

   always @(posedge clk)
     begin
	code = $fread(mem1, fd, 0, 1);
	code = $fread(mem2, fd, 0, 1);
	code = $fread(mem3, fd, 0, 1);
	code = $fread(mem4, fd, 0, 1);
	if (!code)
	  $finish;
//	$display ("success");
     end // always @ (posedge clk)

   wire [6:0]    opcode;

   wire [4:0]	 rd;
   wire [4:0]	 rs1;
   wire [4:0]	 rs2;
   wire [2:0]	 funct3;
   wire [6:0]	 funct7;

   wire [31:0] imm;
   wire	       write_rd;

   wire	       OP_IMM;
   wire	       LUI;
   wire	       AUIPC;
   wire	       OP;
   wire	       JAL;
   wire	       JALR;
   wire	       BRANCH;
   wire	       LOAD;
   wire	       STORE;
   wire	       MISC_MEM;
   wire	       SYSTEM;

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

endmodule
