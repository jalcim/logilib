`include "../../../src/routing/src/demux.v"
`include "../../../src/routing/src/mux.v"
`include "../../../src/memory/latch/Dlatch/src/serial_Dlatch.v"

module blockreg(clk,
		reset, write,
		write_addr, read_A, read_B,
		datain, data_out_A, data_out_B,
		error);

   wire out_write_demux;

   write_demux write_demux(clk, write, write_addr, out_write_demux);

   //32 registre de 32 bit (data, clk, Q, QN);

   read_mux read_A(addr_A, /*Q*/, out_read_A);
   read_mux read_B(addr_B, /*Q*/, out_read_B);
   
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
