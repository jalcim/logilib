`include "../../../src/routing/src/demux.v"
`include "../../../src/routing/src/mux.v"

module write_demux(clk, addr_write_reg, write, out_write_demux);
   parameter WAY = 5;

   input clk, write;
   input [WAY-1:0] addr_write_reg;
   output [(2**WAY)-1:0] out_write_demux;

   wire and_out;
   and and0(and_out, clk, write);
   demux #(.S(WAY)) demux0(addr_write_reg, and_out, out_write_demux);
endmodule

module read_mux(read_addr, out_reg, out_read_mux);
   parameter WAY = 5;

   input [WAY-1:0] read_addr;
   input [2**WAY:0] out_reg;
   output 	    out_read_mux;

   mux #(.S(WAY)) mux0(read_addr, out_reg, out_read_mux);
endmodule
