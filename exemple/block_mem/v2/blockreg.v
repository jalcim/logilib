`include "../../../src/memory/latch/Dlatch/src/parallel_Dlatch.v"
`include "../../../src/memory/latch/Dlatch/src/serial_Dlatch.v"

`include "mux_demux.v"

module blockreg(clk,
		reset, write,
		write_ref, read_A, read_B,
		datain,
		data_out_A, data_out_B);

   localparam NB_REG = 32;
   localparam SIZE_REG = 32;
   localparam SIZE = NB_REG * SIZE_REG;

   input clk, reset, write;
   input [4:0] addr_write_reg, read_A, read_B;
   input [SIZE_REG:0] datain;

   output [SIZE_REG-1:0] data_out_A, data_out_B;

   wire out_write_demux;
   wire [SIZE -1 : 0 ]D, Q, QN;

   write_demux write_demux(clk, addr_write_reg, write, out_write_demux);

   replicator #(.WAY(NB_REG), .WIRE(SIZE_REG)) replicator(D, datain);
   parallel_Dlatch #(.WAY(NB_REG), .WIRE(SIZE_REG))block_Dlatch(D, out_write_demux, Q, QN);

   read_mux read_A(read_A, Q, data_out_A);
   read_mux read_B(read_B, Q, data_out_B);

endmodule

