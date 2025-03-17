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

 `include "exemple/alu/bru/bru.v"

module alu_primary(datain_A, datain_B,
		   funct3, funct7,
		   SIGNAL_bru, SIGNAL_pc,
		   pc, imm_b, data);

   localparam WAY = 8;
   localparam WIRE = 32;
   localparam SIZE_CTRL = 3;

   input [WIRE-1:0] datain_A, datain_B;
   input [2:0]	    funct3;
   input [6:0]	    funct7;
   input	    SIGNAL_bru;
   input [31:0]	    pc, imm_b;

   output [WIRE-1:0]	  data;
   output		  SIGNAL_pc;

   wire [WAY*WIRE-1:0]	  line;
   wire			  ignore_cout;

   supply0		  ignore_cin;

   wire [WIRE-1:0]	  add_sub_out, sll_out    , slt_out, sltu_out;
   wire [WIRE-1:0]	  xor_out    , sra_srl_out, or_out , and_out ;
   wire [WIRE-1:0]	  prim_out;

   bru bru_inst(add_sub_out, funct3, SIGNAL_bru, SIGNAL_pc);

   or or_sig_sub(sig_sub, funct7, SIGNAL_bru);
   add_sub #(.WIRE(WIRE)) inst_add_sub(datain_A, datain_B,
				       ignore_cin, sig_sub,
				       add_sub_out,
				       //line[1 * WIRE-1:(1-1) * WIRE],
				       ignore_cout);

   sll  #(.WIRE(WIRE)) sll_inst(datain_A, datain_B,
				//line[2 * WIRE-1:(2-1) * WIRE]
				sll_out);

   slt  #(.WIRE(WIRE)) slt_inst (datain_A, datain_B,
				 //line[3 * WIRE-1:(3-1) * WIRE]
				 slt_out);

   sltu #(.WIRE(WIRE)) sltu_inst (datain_A, datain_B,
				  //line[4 * WIRE-1:(4-1) * WIRE]
				  sltu_out);

   gate_xor #(.WAY(2), .WIRE(WIRE)) xor_inst(xor_out,
					     //line[5 * WIRE-1:(5-1) * WIRE],
					     {datain_A, datain_B});

   sra_srl #(.WIRE(WIRE)) sra_srl_inst (funct7, datain_A, datain_B,
					//line[6 * WIRE-1:(6-1) * WIRE]
					sra_srl_out);

   gate_or  #(.WAY(2), .WIRE(WIRE)) or_inst (or_out,
					     //line[7 * WIRE-1:(7-1) * WIRE],
					     {datain_A, datain_B});

   gate_and #(.WAY(2), .WIRE(WIRE)) and_inst(and_out,
					     //line[8 * WIRE-1:(8-1) * WIRE],
					     {datain_A, datain_B});

   assign line = {and_out , or_out , sra_srl_out, xor_out,
		  sltu_out, slt_out, sll_out    , add_sub_out};
   mux #(.SIZE_CTRL(SIZE_CTRL), .WIRE(WIRE)) read_mux(funct3, line, prim_out);
   alu_secondary secondary(SIGNAL_pc, pc, imm_b, prim_out, data);
endmodule

`include "src/alu/arithm/addX.v"
module alu_secondary(signal_pc, pc, imm_b, prim_out, data);
   input signal_pc;
   input [31:0]	pc, imm_b, prim_out;

   output [31:0] data;

   wire ignore;
   wire [31:0]	 out_addx;

   addX #(.WIRE(32)) addX_inst(pc, imm_b, 1'b0, out_addx, ignore);
   assign data = signal_pc ? out_addx : prim_out;
endmodule

`endif
