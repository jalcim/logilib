module mem_4(write, read, clk, activate, addrin,
	     addrout, datain, dataout, error);
   input write, read, clk, activate;
   input [3:0] addrin, addrout;
   input [7:0] datain;

   output      error;
   output [7:0] dataout;

   wire 	out_and0;
   
   gate_and and0(write, activate, out_and0);
   demultiplexeur_1x16()
   
endmodule // mem_4

module 
