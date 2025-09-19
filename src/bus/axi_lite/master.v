module axi4_master (input	      axi_aclk,
		    input	      axi_rstn,
		    input	      enable,

		    output reg [31:0] m_axi_awaddr,
		    output reg	      m_axi_awvalid,
		    input	      s_axi_awready,

		    output reg [31:0] m_axi_wdata,
		    output reg [3:0]  m_axi_wstrb,
		    output reg	      m_axi_wvalid,
		    input	      s_axi_wready,

		    input [1:0]	      s_axi_bresp,
		    input	      s_axi_bvalid,
		    output reg	      m_axi_bready,

		    output reg [31:0] m_axi_araddr,
		    output reg	      m_axi_arvalid,
		    input	      s_axi_arready,

		    input [31:0]      s_axi_rdata,
		    input	      s_axi_rvalid,
		    input [1:0]	      s_axi_rresp,
		    output reg	      m_axi_rready
		    );

   integer cpt = 0;

   always @(posedge axi_aclk or negedge axi_rstn)
     begin
	if (enable)
	  cpt = cpt + 1;
	if (cpt == 5)
	  $finish;

	if (~axi_rstn)
	  begin
	     m_axi_awaddr <= 0;
   	     m_axi_awvalid <= 0;

	     m_axi_wdata <= 0;
	     m_axi_wstrb <= 0;
   	     m_axi_wvalid <= 0;

   	     m_axi_bready <= 0;

	     m_axi_araddr <= 0;
   	     m_axi_arvalid <= 0;

   	     m_axi_rready <= 0;
	  end
	else if (axi_aclk && enable)
	  begin
	     if (~m_axi_awvalid)
	       begin
		  $display("ecriture address write %d cycle\n", cpt);
		  m_axi_awaddr <= 10;
		  m_axi_awvalid <= 1;
	       end

	     if (~m_axi_wvalid)
	       begin
		  $display("ecriture data write %d cycle\n", cpt);
		  m_axi_wdata <= 31;
		  m_axi_wstrb <= 4'b1111;
		  m_axi_wvalid <= 1;
	       end

	     if (~m_axi_arvalid)
	       begin
		  $display("ecriture addresse read %d cycle\n", cpt);
		  m_axi_araddr <= 5;
		  m_axi_arvalid <= 1;
	       end

////////////////////////////////////////////////////////////

//	     if (s_axi_arready & ~m_axi_rready)
	     if (s_axi_rvalid & ~m_axi_rready)
	       begin
		  $display("lecture data read %d cycle\n", cpt);
		  m_axi_rready <= 1;
	       end

	     if(s_axi_bvalid & ~m_axi_bready)
	       begin
		  $display("reception reponse %d cycle\n", cpt);
		  m_axi_bready <= 1;
	       end

////////////////////////////////////////////////////////////

	     if(s_axi_rvalid & m_axi_rready)
	       begin
		  $display("reset block lecture data %d cycle\n", cpt);
		  m_axi_rready <= 0;
	       end
	  end
     end
endmodule
