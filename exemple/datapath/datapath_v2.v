module datapath(instr);
   input [31:0] instr;

   
   registers registers (read_A, read_B, write_reg, write_data, reg_writercra, A, B);

   mux mux1(alu_ctrl, {B, imm}, alu_B);

   alu alu(A, alu_B, alu_op, alu_result);

   memory memory(alu_result, write_data, read_data, mem_write, mem_read);

   mux mux2(mem_to_reg, {read_data, alu_result}, write_data)

endmodule
