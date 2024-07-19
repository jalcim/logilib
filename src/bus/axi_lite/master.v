`timescale 1ns / 1ns

module axi_lite_master(
		       // Déclaration des ports du module axi
		       output reg [7:0]	 s_axi_awaddr,
		       output reg	 s_axi_awvalid,
		       input		 s_axi_awready,

		       output reg [7:0]	 s_axi_araddr,
		       output reg	 s_axi_arvalid,
		       input		 s_axi_arready,

		       output reg [31:0] s_axi_wdata,
		       output reg [3:0]	 s_axi_wstrb,
		       output reg	 s_axi_wvalid,
		       input		 s_axi_wready,

		       input [31:0]	 s_axi_rdata,
		       output reg	 s_axi_rready,

		       input [1:0]	 s_axi_bresp,
		       input		 s_axi_bvalid,
		       output reg	 s_axi_bready,

		       input [1:0]	 s_axi_rresp,
		       input		 s_axi_rvalid,

		       input		 axi_aclk,
		       input		 resetn
		       );
   reg					 init;

   always @(posedge axi_aclk)
     begin
	if (!resetn)
	  begin
	     s_axi_awaddr  <= 0;
	     s_axi_awvalid <= 0;
	     s_axi_araddr  <= 0;
	     s_axi_arvalid <= 0;
	     s_axi_wdata   <= 0;
	     s_axi_wstrb   <= 0;
	     s_axi_wvalid  <= 0;
	     s_axi_rready  <= 0;
	     s_axi_bready  <= 0;
	     init <= 0;
	  end
	else
	  begin
	     // Transaction d'écriture
	     if (!init)
	       begin
		  s_axi_awaddr <= 1;
		  s_axi_awvalid <= 1;
		  init <= 1;
	       end

	     if (s_axi_awready)
	       begin
		  s_axi_wdata <= 32'h12345678;
		  s_axi_wstrb <= 4'b1111;
		  s_axi_wvalid <= 1;
	       end
	     else
	       begin
		  s_axi_wstrb <= 0;
		  s_axi_wvalid <= 0;
	       end
		 
	     // Attendre que s_axi_awready et s_axi_wready
	     // soient valides
	     if (s_axi_awready)
	       begin
		  s_axi_awvalid <= 0;
	       end

	     if (s_axi_wready)
	       begin
		  s_axi_wvalid <= 0;
	       end

	     //Attendre la réponse d'écriture
	     //Vérifier la réponse d'écriture
	     if (!s_axi_bready && s_axi_bvalid)// && s_axi_bresp == 2'b00)
	       begin
		  // Transaction de lecture
		  s_axi_bready <= 1;
		  s_axi_arvalid <= 1;
		  s_axi_araddr <= 8'h01;
	       end
	     else
	       begin
		  s_axi_bready <= 0;
		  s_axi_arvalid <= 0;
	       end

	     // Attendre que s_axi_arready soit valide
	     if (s_axi_arready)
	     begin
		s_axi_arvalid <= 0;
		s_axi_rready <= 1;
		s_axi_bready <= 0;
	     end

	     // Attendre la réponse de lecture
	     if (s_axi_rvalid)
	       begin
		  s_axi_rready <= 0;
		  $finish;
	       end

	     if (s_axi_arready && s_axi_rvalid)
	       init <= 0;
      // Terminer la simulation
	  end
     end

endmodule
