`ifndef __PC__
 `define __PC__

 `include "src/alu/arithm/addX.v"
 `include "src/memory/Dflipflop/Dflipflop_rst.v"

module pc(clk, signal_pc, pc_reset, pc_next, pc_out);
   input clk;
   input pc_reset;
   input signal_pc;
   input [31:0]	pc_next;

   output [31:0] pc_out;

   wire [31:0]	 out_add;
   wire		 ignore;
   wire [31:0]	 line_pc_out;
   wire [31:0]	 line_pc_ignored;
   wire [31:0]	 line;

   addX #(.WIRE(32)) addX_inst(line_pc_out, 4, 1'b0, out_add, ignore);
   assign line = signal_pc ? pc_next : out_add;
   Dflipflop_rst #(.WAY(1), .WIRE(32)) Dflipflop_rst_inst(line, clk, pc_reset, line_pc_out, line_pc_ignored);
   assign pc_out = line_pc_out;
endmodule

`endif
