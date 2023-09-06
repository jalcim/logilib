`include "../../../src/routing/src/demux.v"
`include "../../../src/routing/src/mux.v"

`include "../../../src/memory/latch/Dlatch/src/parallel_Dlatch.v"
`include "../../../src/memory/latch/Dlatch/src/serial_Dlatch.v"

module blockreg(clk,
		reset, write,
		write_ref, read_A, read_B,
		datain,
		data_out_A, data_out_B);

   localparam NB_REG = 32;
   localparam SIZE_REG = 32;
   localparam SIZE = NB_REG * SIZE_REG;

   input clk, reset, write;
   input [4:0] write_reg, read_A, read_B;
   input [SIZE_REG:0] datain;

   output [SIZE_REG-1:0] data_out_A, data_out_B;

   wire out_write_demux;
   wire [SIZE -1 : 0 ]D, Q, QN;

   write_demux write_demux(clk, write, write_reg, out_write_demux);

   replicator #(.WAY(NB_REG), .WIRE(SIZE_REG)) replicator(D, datain);

   parallel_Dlatch #(.WAY(NB_REG), .WIRE(SIZE_REG))block_Dlatch(D, out_write_demux, Q, QN);

   read_mux read_A(read_A, Q, data_out_A);
   read_mux read_B(read_B, Q, data_out_B);

endmodule

module write_demux(clk, write, write_addr, out_write_demux);
   parameter WAY = 5;

   input clk, write;
   input [WAY-1:0] write_addr;
   output [(2**WAY)-1:0] out_write_demux;

   wire and_out;
   and and0(and_out, clk, write);
   demux #(.S(WAY)) demux0(write_addr, and_out, out_write_demux);
endmodule

module read_mux(read_addr, out_reg, out_read_mux);
   parameter WAY = 5;

   input [WAY-1:0] read_addr;
   input [2**WAY:0] out_reg;
   output 	    out_read_mux;

   mux #(.S(WAY)) mux0(read_addr, out_reg, out_read_mux);
endmodule
