module test_axi4;
   reg axi_aclk;
   reg axi_rstn;
   reg enable;

   wire [31:0] m_axi_awaddr;
   wire	       m_axi_awvalid;
   wire	       s_axi_awready;

   wire [31:0] m_axi_wdata;
   wire [3:0]  m_axi_wstrb;
   wire	       m_axi_wvalid;
   wire	       s_axi_wready;

   wire [1:0]  s_axi_bresp;
   wire	       s_axi_bvalid;
   wire	       m_axi_bready;

   wire [31:0] m_axi_araddr;
   wire	       m_axi_arvalid;
   wire	       s_axi_arready;

   wire [31:0] s_axi_rdata;
   wire	       s_axi_rvalid;
   wire [1:0]  s_axi_rresp;
   wire	       m_axi_rready;

   axi4_master axi4_master(axi_aclk,
			   axi_rstn,
			   enable,

			   m_axi_awaddr,
			   m_axi_awvalid,
			   s_axi_awready,

			   m_axi_wdata,
			   m_axi_wstrb,
			   m_axi_wvalid,
			   s_axi_wready,

			   s_axi_bresp,
			   s_axi_bvalid,
			   m_axi_bready,

			   m_axi_araddr,
			   m_axi_arvalid,
			   s_axi_arready,

			   s_axi_rdata,
			   s_axi_rvalid,
			   s_axi_rresp,
			   m_axi_rready
			   );

   axi4_slave axi4_slave(axi_aclk,
			 axi_rstn,
			 enable,

			 m_axi_awaddr,
			 m_axi_awvalid,
			 s_axi_awready,

			 m_axi_wdata,
			 m_axi_wstrb,
			 m_axi_wvalid,
			 s_axi_wready,

			 s_axi_bresp,
			 s_axi_bvalid,
			 m_axi_bready,

			 m_axi_araddr,
			 m_axi_arvalid,
			 s_axi_arready,

			 s_axi_rdata,
			 s_axi_rvalid,
			 s_axi_rresp,
			 m_axi_rready
			 );

   initial
     begin
	axi_aclk <= 0;
	axi_rstn <= 0;
	enable <= 0;
	#100;

	axi_rstn<= 1;
	#100;

	axi_aclk <= 1;
	enable <= 1;
	#100;

	axi_aclk <= 0;
	#100;
	axi_aclk <= 1;
	#100;
	axi_aclk <= 0;
	#100;
	axi_aclk <= 1;
	#100;
	axi_aclk <= 0;
	#100;
	axi_aclk <= 1;
	#100;
	axi_aclk <= 0;
	#100;
	axi_aclk <= 1;
	#100;
	axi_aclk <= 0;
	#100;
	axi_aclk <= 1;
	#100;
	axi_aclk <= 0;
	#100;
	axi_aclk <= 1;
	#100;
	axi_aclk <= 0;
	#100;
	axi_aclk <= 1;
	#100;
	axi_aclk <= 0;
	#100;
	axi_aclk <= 1;
	#100;
	axi_aclk <= 0;
	#100;
	axi_aclk <= 1;
	#100;
	axi_aclk <= 0;
	#100;
	axi_aclk <= 1;
	#100;
     end

endmodule
