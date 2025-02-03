module mux_store (input [31:0] imm_S,
		  input [2:0]	funct3,
		  output [31:0]	dataout);

   wire [31:0]			line0;
   wire [31:0]			line1;
   wire [31:0]			line2;

   assign line0[7:0] = imm_S[7:0];
   assign line0[31:8] = 24'b0;
//   assign line0[31] = funct3[2] ? imm_S[31] : 0;

   assign line1[15:0] = imm_S[15:0];
   assign line1[31:16] = 16'b0;
//   assign line1[31] = line0[31];

   assign line2 = imm_S;

   ////////////////////////////////////////////////////////////

   assign dataout = ~(funct3[1] | funct3[0]) ? line0 : (funct3[0] ? line1 : line2);

endmodule
