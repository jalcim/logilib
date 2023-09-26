`ifndef __BLOCK_REG__
 `define __BLOCK_REG__

 `include "src/routing/replicator.v"
 `include "src/memory/Dlatch/parallel_Dlatch_rst.v"

module block_reg(clk, reset, write,
		addrin, read_A, read_B,
		datain,
		data_out_A, data_out_B);
   parameter SIZE_ADDR_REG = 5;
   parameter SIZE_REG = 8;

   localparam NB_REG = 2**SIZE_ADDR_REG;
   localparam SIZE = NB_REG * SIZE_REG;

   input      clk, reset, write;
   input [SIZE_ADDR_REG-1:0] addrin, read_A, read_B;
   input [SIZE_REG-1:0]	     datain;

   output [SIZE_REG-1:0]     data_out_A, data_out_B;

   wire [NB_REG-1:0]	     out_write_demux;
   wire [SIZE -1 : 0 ]	     D, Q, QN;

   write_demux #(.SIZE_ADDR_REG(SIZE_ADDR_REG)) write_demux(clk, addrin, write, out_write_demux);

   replicator #(.WAY(NB_REG), .WIRE(SIZE_REG)) replicator(D, datain);
   parallel_Dlatch_rst #(.WAY(NB_REG), .WIRE(SIZE_REG))block_Dlatch(D, out_write_demux, {NB_REG{reset}}, Q, QN);

   read_mux #(.SIZE_ADDR_REG(SIZE_ADDR_REG), .SIZE_REG(SIZE_REG)) read_mux_A(read_A, Q, data_out_A);
   read_mux #(.SIZE_ADDR_REG(SIZE_ADDR_REG), .SIZE_REG(SIZE_REG)) read_mux_B(read_B, Q, data_out_B);

endmodule

`endif

`ifndef __MUX_DEMUX__

 `include "src/routing/demux.v"
 `include "src/routing/mux.v"

module write_demux(clk, addrin, write, out_write_demux);
   parameter SIZE_ADDR_REG = 5;

   input clk, write;
   input [SIZE_ADDR_REG-1:0] addrin;
   output [(2**SIZE_ADDR_REG)-1:0] out_write_demux;

   wire and_out;
   and and0(and_out, clk, write);
   demux #(.SIZE_CTRL(SIZE_ADDR_REG)) demux0(addrin, and_out, out_write_demux);
endmodule

module read_mux(read_addr, in, out_read_mux);
   parameter SIZE_ADDR_REG = 5;
   parameter SIZE_REG = 8;
   localparam SIZE_IN = (2**SIZE_ADDR_REG) * SIZE_REG;

   input [SIZE_ADDR_REG-1:0] read_addr;
   input [SIZE_IN-1:0] in;

   output [SIZE_REG-1:0]	    out_read_mux;

   mux #(.SIZE_CTRL(SIZE_ADDR_REG), .WIRE(SIZE_REG)) mux0(read_addr, in, out_read_mux);
endmodule

`endif
