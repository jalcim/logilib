module axi_register(
                    input         clk,
                    input         ready_to_write,
                    input         ready_to_read,
                    input [7:0]   waddr,
                    input [7:0]   raddr,
                    input [31:0]  wdata,
                    output reg [31:0] rdata
                    );

   localparam NUM_REGS = 128;
   localparam SIZE_REG = 32;

   // Tableau de registres contenant les informations
   reg [SIZE_REG-1:0] 		      reg_array [0:NUM_REGS-1];

   always @(posedge clk)
     begin
	if (ready_to_write
	    && waddr && waddr < NUM_REGS)
	  reg_array[waddr] <= wdata;

	if (ready_to_read && raddr < NUM_REGS)
          rdata <= reg_array[raddr];
	else
          rdata <= 0; // Valeur par défaut si l'adresse de lecture est hors limites
   end
endmodule
