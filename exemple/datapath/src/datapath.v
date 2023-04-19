module datapath(clk, charge, reset, addr_reg, outA, outB, datain, op,
		reg_data_ctrl, reg_datain, Bctrl, datain_ctrl, addrin,
		addrin_ctrl,addrout, addrout_ctrl, read, write, activate,
		out_regA, out_regB, out_alu, out_mem, error);

   parameter WAY_MUX = 2;
   parameter WAY_MUX1 = 1;
   parameter WIRE_MUX = 8;
   
   parameter WIRE_BLOCKREG = 3;

   parameter S = 4;
   parameter T1 = 8;
   parameter T2 = 1;

   input clk, charge, reset, Bctrl, read, write, activate;
   input [1:0] addr_reg, outA, outB, reg_data_ctrl, datain_ctrl, addrin_ctrl, addrout_ctrl;
   input [3:0] op;
   input [7:0] datain, reg_datain, addrin, addrout;

   output [7:0] out_regA, out_regB, out_alu, out_mem;
   output 	error;

   wire [7:0]  mux0_out, mux1_out, mux2_out, mux3_out, mux4_out, memory_out;
   wire        error0, error1;

   wire [7:0]  out_line_A, out_line_B, alu_out;

   recurse_mux #(.S(WAY_MUX), .T(WIRE_MUX)) mux0(reg_data_ctrl[1:0], {memory_out[7:0], reg_datain[7:0], alu_out[7:0], out_line_B}, mux0_out[7:0]);

   blockreg blockreg(clk, reset, charge, addr_reg[1:0], outA[1:0], outB[1:0], mux0_out[7:0], out_line_A[7:0], out_line_B[7:0], error0);
   recursive_buf #(.S(WIRE_BLOCKREG))recursive_buf_out_A(out_line_A[7:0], out_regA[7:0]);
   recursive_buf #(.S(WIRE_BLOCKREG))recursive_buf_out_B(out_line_B[7:0], out_regB[7:0]);

   recurse_mux #(.S(WAY_MUX1), .T(WIRE_MUX)) mux1(Bctrl, {datain[7:0] ,out_line_B[7:0]}, mux1_out[7:0]);

   alu #(.S(S), .T1(T1), .T2(T2)) alu0(clk, op, out_line_A[7:0], mux1_out[7:0], alu_out[7:0]);
   recursive_buf #(.S(WIRE_BLOCKREG))recursive_buf_out_alu(alu_out[7:0], out_alu[7:0]);   

   recurse_mux #(.S(WAY_MUX), .T(WIRE_MUX)) mux2(datain_ctrl[1:0], {memory_out[7:0], datain[7:0], alu_out[7:0], out_line_B[7:0]}, mux2_out[7:0]);

   recurse_mux #(.S(WAY_MUX), .T(WIRE_MUX)) mux3(addrin_ctrl[1:0], {memory_out[7:0], addrin[7:0], alu_out[7:0], out_line_B[7:0]}, mux3_out[7:0]);

   recurse_mux #(.S(WAY_MUX), .T(WIRE_MUX)) mux4(addrout_ctrl[1:0], {memory_out[7:0], addrout[7:0], alu_out[7:0], out_line_B[7:0]}, mux4_out[7:0]);

   memory memory(write, read, clk, reset, activate, mux3_out[3:0], mux4_out[3:0], mux2_out[7:0], memory_out[7:0], error1);
   recursive_buf #(.S(WIRE_BLOCKREG))recursive_buf_out_mem(memory_out[7:0], out_mem[7:0]);   

   gate_or or_error(error0, error1, error);

endmodule
