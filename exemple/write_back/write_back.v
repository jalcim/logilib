`ifndef __WRITE_BACK__
 `define __WRITE_BACK__

 `include "src/memory/Dflipflop/Dflipflop_rst.v"
 `include "src/routing/mux.v"

module write_back(clk, reset, write_rd_in, rd_in,
		  alu, lui_auipc, jal_jalr, lsu,
		  signal_lui, signal_auipc, signal_jal, signal_jalr, signal_load,
		  write_rd_out, rd_out, dataout);
   input clk, reset, write_rd_in;
   input [4:0] rd_in;
   input [31:0]	alu, lui_auipc, jal_jalr, lsu;
   input	signal_lui, signal_auipc, signal_jal, signal_jalr, signal_load;

   output	write_rd_out;
   output [4:0] rd_out;
   output [31:0] dataout;

   wire [1:0]	 ctrl;
   wire [127:0]	 in;

   wire		 ignored_write_rd;
   wire	[4:0]	 ignored_rd_out;

   Dflipflop_rst #(.WAY(1), .WIRE(1)) Dflipflop_rst_inst1(write_rd_in, clk, reset, write_rd_out, ignored_write_rd);
   Dflipflop_rst #(.WAY(1), .WIRE(5)) Dflipflop_rst_inst2(rd_in      , clk, reset, rd_out      , ignored_rd_out);

   assign ctrl = {(signal_jal | signal_jalr | signal_load), (signal_lui | signal_auipc | signal_load)};
   assign in = {lsu, jal_jalr, lui_auipc, alu};
   mux #(.SIZE_CTRL(2), .WIRE(32)) mux0(ctrl, in, dataout);
endmodule

`endif
