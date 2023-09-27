`ifndef __ALU__
 `define __ALU__

 `include "src/alu/arithm/add_sub.v"

 `include "src/primitive/gate/gate_xor.v"

 `include "src/primitive/gate/gate_or.v"
 `include "src/primitive/gate/gate_and.v"

module alu(datain_A, datain_B, funct3, funct7, out);
   localparam WAY = 8;
   localparam WIRE = 32;
   localparam SIZE_CTRL = 3;

   input [WIRE-1:0] datain_A, datain_B;
   input [SIZE_CTRL-1 :0] funct3;
   input		  funct7;

   output [WIRE-1:0]	  out;

   wire [WAY*WIRE-1:0]	  line;

   wire [WIRE-1:0]	  ignore;

   add_sub #(.WIRE(32)) inst_add_sub(datain_A, datain_B, funct7,
				     line[1 * WIRE-1:(1-1) * WIRE], ignore);
   //sll  line[2 * WIRE-1:(2-1) * WIRE]
   //slt  line[3 * WIRE-1:(3-1) * WIRE]
   //sltu line[4 * WIRE-1:(4-1) * WIRE]
   gate_xor #(.WAY(2), .WIRE(WIRE)) xor_inst(datain_A, datain_B,
					   line[5 * WIRE-1:(5-1) * WIRE]);
   //sra/srl line[6 * WIRE-1:(6-1) * WIRE]
   gate_or  #(.WAY(2), .WIRE(WIRE)) or_inst (datain_A, datain_B,
					     line[7 * WIRE-1:(7-1) * WIRE]);
   gate_and #(.WAY(2), .WIRE(WIRE)) and_inst(datain_A, datain_B,
					     line[8 * WIRE-1:(8-1) * WIRE]););

   mux #(.SIZE_CTRL(SIZE_CTRL), .WIRE(WIRE)) read_mux(funct3, line, )
endmodule
