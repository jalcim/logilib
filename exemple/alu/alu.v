`ifndef __ALU__
 `define __ALU__

 `include "src/alu/arithm/add_sub.v"
 `include "src/alu/logic/sll.v"
 `include "src/alu/logic/slt.v"
 `include "src/alu/logic/sltu.v"
 `include "src/primitive/gate/gate_xor.v"
 `include "src/alu/logic/sra_srl.v"
 `include "src/primitive/gate/gate_or.v"
 `include "src/primitive/gate/gate_and.v"

 `include "src/routing/mux.v"

module alu(datain_A, datain_B, funct3, funct7, out);
   localparam WAY = 8;
   localparam WIRE = 32;
   localparam SIZE_CTRL = 3;

   input [WIRE-1:0] datain_A, datain_B;
   input [SIZE_CTRL-1 :0] funct3;
   input		  funct7;

   output [WIRE-1:0]	  out;

   wire [WAY*WIRE-1:0]	  line;

   wire			  ignore_cout;
   supply0		  ignore_cin;

   add_sub #(.WIRE(32)) inst_add_sub(datain_A, datain_B,
				     ignore_cin, funct7,
				     line[1 * WIRE-1:(1-1) * WIRE],
				     ignore_cout);
   sll  #(.WIRE(WIRE)) sll_inst(datain_A, datain_B,
				line[2 * WIRE-1:(2-1) * WIRE]);

   slt  #(.WIRE(WIRE)) slt_inst (datain_A, datain_B,
				 line[3 * WIRE-1:(3-1) * WIRE]);

   sltu #(.WIRE(WIRE)) sltu_inst (datain_A, datain_B,
				  line[4 * WIRE-1:(4-1) * WIRE]);
   
   gate_xor #(.WAY(2), .WIRE(WIRE)) xor_inst(line[5 * WIRE-1:(5-1) * WIRE],
					     {datain_A, datain_B});

   sra_srl #(.WIRE(WIRE)) sra_srl_inst (funct7, datain_A, datain_B,
					line[6 * WIRE-1:(6-1) * WIRE]);

   gate_or  #(.WAY(2), .WIRE(WIRE)) or_inst (line[7 * WIRE-1:(7-1) * WIRE],
					     {datain_A, datain_B});
   gate_and #(.WAY(2), .WIRE(WIRE)) and_inst(line[8 * WIRE-1:(8-1) * WIRE],
					     {datain_A, datain_B});

   mux #(.SIZE_CTRL(SIZE_CTRL), .WIRE(WIRE)) read_mux(funct3, line, out);
endmodule

`endif
