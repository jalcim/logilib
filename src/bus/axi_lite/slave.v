module axi_lite_slave(
		      (* X_INTERFACE_PARAMETER = "FREQ_HZ 125000000" *)
		      // Interface Write Address
		      input [7:0]      s_axi_awaddr, //s_axi_awaddr: Adresse d'écriture (8 bits).
		      input	       s_axi_awvalid, //Adresse d'écriture valide (1 bit).
		      output reg       s_axi_awready, //Prêt à accepter l'adresse d'écriture (1 bit).

		     // Interface Read Address
		      input [7:0]      s_axi_araddr, //Adresse de lecture (8 bits).
		      input	       s_axi_arvalid, //Adresse de lecture valide (1 bit).
		      output reg       s_axi_arready, //Prêt à accepter l'adresse de lecture (1 bit).
		     
		     // Interface Write Data
		      input [31:0]     s_axi_wdata, //Données d'écriture (32 bits).
		      input [3:0]      s_axi_wstrb, //Masque d'octets valides (4 bits).
		      input	       s_axi_wvalid, //Données d'écriture valides (1 bit).
		      output reg       s_axi_wready, //Prêt à accepter les données d'écriture (1 bit).

		     // Interface Read Data
		      output [31:0]    s_axi_rdata, //Données de lecture (32 bits).
		      input	       s_axi_rready, //Prêt à accepter les données de lecture (1 bit).

		     // Interface Write Response
		      output reg [1:0] s_axi_bresp, //Statut de l'écriture (2 bits).
		      output reg       s_axi_bvalid, //Réponse d'écriture valide (1 bit).
		      input	       s_axi_bready, //Prêt à accepter la réponse d'écriture (1 bit).

		     // Interface Read Response
		      output reg [1:0] s_axi_rresp, //Statut de la lecture (2 bits).
		      output reg       s_axi_rvalid, //Données de lecture valides (1 bit).
		     //s_axi_rready joue aussi le role de signal pret a accepter la reponse

		      input	       axi_aclk,
		      input	       resetn
	   );

   localparam BYTE		       = 8;

   reg [7:0]			       s_axi_awaddr_d;
   reg [7:0]			       s_axi_araddr_d;

   wire [31:0]			       s_axi_wdata_i;

   always @(posedge axi_aclk)
     begin
	if (!resetn)
	  begin
	     s_axi_wready  <= 0;
	     s_axi_awaddr_d  <= 0;
	     s_axi_awready <= 0;
	     s_axi_bvalid  <= 0;
             s_axi_bresp   <= 0;
             s_axi_arready <= 0;
	     s_axi_araddr_d  <= 0;
	     s_axi_rvalid  <= 0;
             s_axi_rresp   <= 0;
	  end
	else
	  begin
	     //(2) lecture de l'address d'ecriture
	     if (!s_axi_awready && s_axi_awvalid)
	       begin
		  s_axi_awready  <= 1;
		  s_axi_awaddr_d <= s_axi_awaddr;
	       end

	     //(4) //rdy_to_write
	     if (!s_axi_wready && s_axi_wvalid)
	       begin
		  s_axi_wready <= 1;
	       end

	     //(5) reponse d'ecriture
//	     if (!s_axi_bvalid && s_axi_wready)//ou direct sur wvalid???
	     if (!s_axi_bvalid && s_axi_wvalid)
	       begin
		  s_axi_bresp  <= 0;
		  s_axi_bvalid <= 1;
	       end

	     //(7) lecture de l'address de lecture
	     if (!s_axi_arready && s_axi_arvalid)
	       begin
		  s_axi_arready  <= 1;
		  s_axi_araddr_d <= s_axi_araddr;
	       end
	     
	     //(9) read et reponse de lecture
	     if(!s_axi_rvalid && s_axi_rready)
	       begin
		  s_axi_rvalid <= 1;
		  s_axi_rresp  <= 0;
	       end

	  end
     end

   assign s_axi_wdata_i[1*BYTE-1:0*BYTE] = s_axi_wstrb[0] ? s_axi_wdata[1*BYTE-1:0*BYTE]:0;
   assign s_axi_wdata_i[2*BYTE-1:1*BYTE] = s_axi_wstrb[1] ? s_axi_wdata[2*BYTE-1:1*BYTE]:0;
   assign s_axi_wdata_i[3*BYTE-1:2*BYTE] = s_axi_wstrb[2] ? s_axi_wdata[3*BYTE-1:2*BYTE]:0;
   assign s_axi_wdata_i[4*BYTE-1:3*BYTE] = s_axi_wstrb[3] ? s_axi_wdata[4*BYTE-1:3*BYTE]:0;

   axi_register register(axi_aclk,
			 s_axi_wready, s_axi_rready,
			 s_axi_awaddr_d, s_axi_araddr_d,
			 s_axi_wdata_i, s_axi_rdata);

endmodule
