module test_memory;
   reg write, read, clk, reset, activate;
   reg [3:0] addrin, addrout;
   reg [7:0] datain;

   wire [7:0] dataout;
   wire       error;

   memory memory(write, read, clk, activate, addrin,
		 addrout, datain, dataout, error);
   
endmodule // test_memory
