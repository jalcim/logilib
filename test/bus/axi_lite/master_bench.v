`timescale 1ns / 1ns

module axi_lite_master_bench;
   // Déclaration des ports du module axi
   wire [7:0] s_axi_awaddr;
   wire	     s_axi_awvalid;
   wire	     s_axi_awready;

   wire [7:0] s_axi_araddr;
   wire	      s_axi_arvalid;
   wire	      s_axi_arready;

   wire [31:0] s_axi_wdata;
   wire [3:0]  s_axi_wstrb;
   wire	       s_axi_wvalid;
   wire	       s_axi_wready;

   wire [31:0]  s_axi_rdata;
   wire	       s_axi_rready;

   wire [1:0]   s_axi_bresp;
   wire	       s_axi_bvalid;
   wire	       s_axi_bready;

   wire [1:0]   s_axi_rresp;
   wire	       s_axi_rvalid;

   reg	       axi_aclk;
   reg	       resetn;
   reg	       init;

   axi_lite_master axi_master (
			       .s_axi_awaddr   (s_axi_awaddr),
			       .s_axi_awvalid  (s_axi_awvalid),
			       .s_axi_awready  (s_axi_awready),
			       .s_axi_wdata    (s_axi_wdata),
			       .s_axi_wstrb    (s_axi_wstrb),
			       .s_axi_wvalid   (s_axi_wvalid),
			       .s_axi_wready   (s_axi_wready),
			       .s_axi_bresp    (s_axi_bresp),
			       .s_axi_bvalid   (s_axi_bvalid),
			       .s_axi_bready   (s_axi_bready),
			       .s_axi_araddr   (s_axi_araddr),
			       .s_axi_arvalid  (s_axi_arvalid),
			       .s_axi_arready  (s_axi_arready),
			       .s_axi_rdata    (s_axi_rdata),
			       .s_axi_rresp    (s_axi_rresp),
			       .s_axi_rvalid   (s_axi_rvalid),
			       .s_axi_rready   (s_axi_rready),
			       .axi_aclk       (axi_aclk),
			       .resetn         (resetn)
			       );

   axi_lite_slave axi_slave (
			     .s_axi_awaddr   (s_axi_awaddr),
			     .s_axi_awvalid  (s_axi_awvalid),
			     .s_axi_awready  (s_axi_awready),
			     .s_axi_wdata    (s_axi_wdata),
			     .s_axi_wstrb    (s_axi_wstrb),
			     .s_axi_wvalid   (s_axi_wvalid),
			     .s_axi_wready   (s_axi_wready),
			     .s_axi_bresp    (s_axi_bresp),
			     .s_axi_bvalid   (s_axi_bvalid),
			     .s_axi_bready   (s_axi_bready),
			     .s_axi_araddr   (s_axi_araddr),
			     .s_axi_arvalid  (s_axi_arvalid),
			     .s_axi_arready  (s_axi_arready),
			     .s_axi_rdata    (s_axi_rdata),
			     .s_axi_rresp    (s_axi_rresp),
			     .s_axi_rvalid   (s_axi_rvalid),
			     .s_axi_rready   (s_axi_rready),
			     .axi_aclk       (axi_aclk),
			     .resetn         (resetn)
			     );

   initial
     begin
	$dumpfile("axi_lite_master.vcd");
	$dumpvars;
	$monitor("Time=%0t %b s_axi_rdata=%h s_axi_bresp=%h",
		 $time, axi_aclk, s_axi_rdata, s_axi_bresp);
	resetn <= 0;
	axi_aclk <= 1;
	#5;
	resetn <= 1;
	#100;
     end

    always
      begin
         #5 axi_aclk <= ~axi_aclk;
      end

endmodule
