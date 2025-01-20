module OPCODE(input  [6:0]opcode,
	      output [10:0]signal);

   localparam [6:0]  OP_IMM   = 7'h13;
   localparam [6:0]  LUI      = 7'h37;
   localparam [6:0]  AUIPC    = 7'h17;
   localparam [6:0]  OP       = 7'h33;
   localparam [6:0]  JAL      = 7'h6f;
   localparam [6:0]  JALR     = 7'h67;
   localparam [6:0]  BRANCH   = 7'h63;
   localparam [6:0]  LOAD     = 7'h03;
   localparam [6:0]  STORE    = 7'h23;
   localparam [6:0]  MISC_MEM = 7'h0f;
   localparam [6:0]  SYSTEM   = 7'h73;

   assign signal = opcode == OP_IMM   ? 11'b00000000001 :
		   opcode == LUI      ? 11'b00000000010 :
		   opcode == AUIPC    ? 11'b00000000100 :
		   opcode == OP       ? 11'b00000001000 :
		   opcode == JAL      ? 11'b00000010000 :
		   opcode == JALR     ? 11'b00000100000 :
		   opcode == BRANCH   ? 11'b00001000000 :
		   opcode == LOAD     ? 11'b00010000000 :
		   opcode == STORE    ? 11'b00100000000 :
		   opcode == MISC_MEM ? 11'b01000000000 :
		   opcode == SYSTEM   ? 11'b10000000000 : 0;
endmodule
