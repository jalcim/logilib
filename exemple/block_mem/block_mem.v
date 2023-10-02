`ifndef __BLOCK_MEM__
 `define __BLOCK_MEM__

 `include "src/routing/replicator.v"
 `include "src/memory/Dlatch/parallel_Dlatch_rst.v"

module block_mem(clk, reset, signal_write,
		addrin, addrout,
		datain, dataout);

   parameter SIZE_ADDR_MEM = 5;
   parameter SIZE_MEM = 8;

   localparam NB_MEM = 2**SIZE_ADDR_MEM;
   localparam SIZE = NB_MEM * SIZE_MEM;

   input      clk, reset, signal_write;
   input [SIZE_ADDR_MEM-1:0] addrin, addrout;
   input [SIZE_MEM-1:0]	     datain;

   output [SIZE_MEM-1:0]     dataout;

   wire [NB_MEM-1:0]	     out_write_demux;
   wire [SIZE -1 : 0 ]	     D, Q, QN;

   write_demux #(.SIZE_ADDR_MEM(SIZE_ADDR_MEM)) write_demux(clk, addrin, signal_write, out_write_demux);

   replicator #(.WAY(NB_MEM), .WIRE(SIZE_MEM)) replicator(D, datain);
   parallel_Dlatch_rst #(.WAY(NB_MEM), .WIRE(SIZE_MEM))block_Dlatch(D,//datain
								    out_write_demux,//clk
								    {NB_MEM{reset}},//reset
								    Q, QN);//sortie et inverse

   read_mux #(.SIZE_ADDR_MEM(SIZE_ADDR_MEM), .SIZE_MEM(SIZE_MEM)) read_mux_A(addrout, Q, dataout);
endmodule

`endif

`ifndef __MUX_DEMUX__

 `include "src/routing/demux.v"
 `include "src/routing/mux.v"

module write_demux(clk, addrin, signal_write, out_write_demux);
   parameter SIZE_ADDR_MEM = 5;

   input clk, signal_write;
   input [SIZE_ADDR_MEM-1:0] addrin;
   output [(2**SIZE_ADDR_MEM)-1:0] out_write_demux;

   wire and_out;

   and and0(and_out, clk, signal_write);
   demux #(.SIZE_CTRL(SIZE_ADDR_MEM)) demux0(addrin, and_out, out_write_demux);
endmodule

module read_mux(read_addr, in, out);
   parameter SIZE_ADDR_MEM = 5;
   parameter SIZE_MEM = 8;
   localparam SIZE_IN = (2**SIZE_ADDR_MEM) * SIZE_MEM;

   input [SIZE_ADDR_MEM-1:0] read_addr;
   input [SIZE_IN-1:0] in;
   input	       clk, signal_read;

   output [SIZE_MEM-1:0] out;

   mux #(.SIZE_CTRL(SIZE_ADDR_MEM), .WIRE(SIZE_MEM)) mux0(read_addr, in, out);

endmodule

`endif
