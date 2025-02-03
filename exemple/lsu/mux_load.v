module mux_load (input [31:0] mem,
		  input [2:0] funct3,
		  output [31:0]	dataout);
   wire [31:0]	out_0;
   wire [31:0]	out_1;
   wire [31:0]	out_2;

   wire [23:0]	natural;

   wire [23:0]	natural_1;
   assign natural_1 = funct3[2] & mem[7] ? {24{1'b1}} : 24'b0;

   wire [15:0]	natural_2;
   assign natural_2 = funct3[2] & mem[15] ? {16{1'b1}} : 16'b0;   

   assign out_0[31:0] = {natural_1, mem[7:0]};//lb/lbu
   assign out_1[31:0] = {natural_2, mem[15:0]};//lh/lbu
   assign out_2 = mem;

   assign dataout = ~(funct3[1] | funct3[0]) ? out_0 : (funct3[0] ? out_1 : out_2);
endmodule
