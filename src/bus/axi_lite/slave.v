module axi4_slave(input		    axi_aclk,
		  input		    axi_rstn,
		  input		    enable,

		  input [31:0]	    m_axi_awaddr,
		  input		    m_axi_awvalid,
		  output reg	    s_axi_awready,

		  input [31:0]	    m_axi_wdata,
		  input [3:0]	    m_axi_wstrb,
		  input		    m_axi_wvalid,
		  output reg	    s_axi_wready,

		  output reg [1:0]  s_axi_bresp,
		  output reg	    s_axi_bvalid,
		  input		    m_axi_bready,

		  input [31:0]	    m_axi_araddr,
		  input		    m_axi_arvalid,
		  output reg	    s_axi_arready,

		  output reg [31:0] s_axi_rdata,
		  output reg	    s_axi_rvalid,
		  output reg [1:0]  s_axi_rresp,
		  input		    m_axi_rready
		  );
   integer cpt = 0;

   always @(posedge axi_aclk or negedge axi_rstn)
     begin
	if (enable)
	  cpt = cpt + 1;

	if (~axi_rstn)
	  begin
	     s_axi_awready <= 0;

   	     s_axi_wready <= 0;

	     s_axi_bresp <= 0;
   	     s_axi_bvalid <= 0;

	     s_axi_arready <= 0;

	     s_axi_rdata <= 0;
   	     s_axi_rvalid <= 0;
	     s_axi_rresp <= 0;
	  end
	else if (enable)
	  begin
	     if (m_axi_awvalid & ~s_axi_awready)
	       begin
		  $display("on a recu l'addresse write %d cycle\n", cpt);
		  s_axi_awready <= 1;
	       end

	     if (m_axi_wvalid & ~s_axi_wready)
	       begin
		  $display("on a recu la data %d cycle\n", cpt);
		  s_axi_wready <= 1;
	       end

	     if (m_axi_arvalid & ~s_axi_arready)//merge 1
	       begin
		  $display("on a recu addresse read %d cycle\n", cpt);
		  s_axi_arready <= 1;
	       end

////////////////////////////////////////////////////////////

	     if (m_axi_arvalid & ~s_axi_rvalid)//merge 2
	       begin
		  $display("data read renvoyer %d cycle\n", cpt);
		  s_axi_rdata <= 1;
		  s_axi_rvalid <= 1;
		  s_axi_rresp <= 1;
	       end

	     if (m_axi_awvalid & m_axi_wvalid & ~s_axi_bvalid)
	       begin
		  $display("envoi reponse %d cycle\n", cpt);
		  s_axi_bresp <= 1;
		  s_axi_bvalid <= 1;
	       end

////////////////////////////////////////////////////////////

	     if (m_axi_awvalid & s_axi_awready)
	       begin
		  $display("reset block ecriture addr %d cycle\n", cpt);
		  s_axi_awready <= 0;
	       end

	     if (m_axi_wvalid & s_axi_wready)
	       begin
		  $display("reset block ecriture data %d cycle\n", cpt);
		  s_axi_wready <= 0;
	       end	     

	     if (m_axi_arvalid & s_axi_arready)
	       begin
		  $display("reset block lecture addr %d cycle\n", cpt);
		  s_axi_arready <= 0;
	       end

////////////////////////////////////////////////////////////

	  end
     end
endmodule
