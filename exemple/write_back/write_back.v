`ifndef __WRITE_BACK__
 `define __WRITE_BACK__

 `include "src/memory/Dflipflop/Dflipflop_rst.v"
 `include "src/routing/mux.v"

module write_back(
		  input		clk, reset, write_rd_in,
		  input [4:0]	rd_in,
		  input [31:0]	alu, lui_auipc, jal_jalr, lsu,
		  input		signal_lui, signal_auipc, signal_jal, signal_jalr, signal_load,
		  input [31:0]	jal_jalr_pc,

		  output [31:0]	pc_next,
		  output	write_rd_out,
		  output [4:0]	rd_out,
		  output [31:0]	dataout
		  );

    wire [1:0] ctrl;
    wire [127:0] in;

    wire ignored_write_rd;
    wire [4:0] ignored_rd_out;

    Dflipflop_rst #(.WAY(1), .WIRE(1)) Dflipflop_rst_inst1(write_rd_in, clk, reset, write_rd_out, ignored_write_rd);
    Dflipflop_rst #(.WAY(1), .WIRE(5)) Dflipflop_rst_inst2(rd_in, clk, reset, rd_out, ignored_rd_out);

    assign ctrl = {(signal_jal | signal_jalr | signal_load), (signal_lui | signal_auipc | signal_load)};
    assign in = {lsu, jal_jalr, lui_auipc, alu};
    assign pc_next = jal_jalr_pc | alu;
    
    mux #(.SIZE_CTRL(2), .WIRE(32)) mux0(ctrl, in, dataout);

endmodule

`endif
