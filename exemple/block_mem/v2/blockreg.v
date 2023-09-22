`ifndef __BLOCKREG__
 `define __BLOCKREG__

 `include "src/routing/replicator.v"
 `include "src/memory/Dlatch/parallel_Dlatch.v"

module blockreg(clk, reset, write,
		addr_write_reg, read_A, read_B,
		datain,
		data_out_A, data_out_B);
   parameter SIZE_ADDR_REG = 5;
   
   localparam NB_REG = 2**SIZE_ADDR_REG;
   localparam SIZE_REG = 32;
   localparam SIZE = NB_REG * SIZE_REG;

   input      clk, reset, write;
   input [SIZE_ADDR_REG-1:0] addr_write_reg, read_A, read_B;
   input [SIZE_REG:0]	     datain;

   output [SIZE_REG-1:0]     data_out_A, data_out_B;

   wire			     out_write_demux;
   wire [SIZE -1 : 0 ]	     D, Q, QN;

   write_demux #(.SIZE_ADDR_REG(SIZE_ADDR_REG)) write_demux(clk, addr_write_reg, write, out_write_demux);

   replicator #(.WAY(NB_REG), .WIRE(SIZE_REG)) replicator(D, datain);
   parallel_Dlatch #(.WAY(NB_REG), .WIRE(SIZE_REG))block_Dlatch(D, out_write_demux, Q, QN);

   read_mux #(.SIZE_ADDR_REG(SIZE_ADDR_REG)) read_mux_A(read_A, Q, data_out_A);
   read_mux #(.SIZE_ADDR_REG(SIZE_ADDR_REG)) read_mux_B(read_B, Q, data_out_B);

endmodule

`endif

`ifndef __MUX_DEMUX__

 `include "src/routing/demux.v"
 `include "src/routing/mux.v"

module write_demux(clk, addr_write_reg, write, out_write_demux);
   parameter SIZE_ADDR_REG = 5;

   input clk, write;
   input [SIZE_ADDR_REG-1:0] addr_write_reg;
   output [(2**SIZE_ADDR_REG)-1:0] out_write_demux;

   wire and_out;
   and and0(and_out, clk, write);
   demux #(.S(SIZE_ADDR_REG)) demux0(addr_write_reg, and_out, out_write_demux);
endmodule

module read_mux(read_addr, out_reg, out_read_mux);
   parameter SIZE_ADDR_REG = 5;

   input [SIZE_ADDR_REG-1:0] read_addr;
   input [2**SIZE_ADDR_REG:0] out_reg;
   output 	    out_read_mux;

   mux #(.S(SIZE_ADDR_REG)) mux0(read_addr, out_reg, out_read_mux);
endmodule

`endif
