module pf3_register(input clk,
		    input [7:0] waddr,
		    input [7:0] raddr,
		    input [31:0]  wdata,
		    output [31:0] rdata
		    );

   localparam SIZE_REG = 32;

   //registre de base contenant les informations sur les autres registres
   reg [4095:0] 		  reg0;

   always @(posedge clk)
     begin
	if (waddr < reg0[31:0])
	  begin
	     genvar counter;
	     generate
		for (counter = 0; counter < 127; counter = counter+1)
		  begin
		     if (waddr == counter)
		       reg0[((counter+2)*SIZE_REG)-1:counter*SIZE_REG] <= wdata;
		  end
	     endgenerate
	  end

	if (raddr < reg0[31:0])
	  begin
	     genvar counter;
	     generate
		for (counter = 0; counter < 127; counter = counter+1)
		  begin
		     if (raddr == counter)
		       rdata <= reg0[((counter+2)*SIZE_REG)-1:counter*SIZE_REG];
		  end
	     endgenerate
	  end

     end

endmodule
