`timescale 1ns / 1ns

module testbench_axi;

    // Déclaration des ports du module axi
    reg [7:0]   s_axi_awaddr;
    reg         s_axi_awvalid;
    wire        s_axi_awready;
    reg [31:0]  s_axi_wdata;
    reg [3:0]   s_axi_wstrb;
    reg         s_axi_wvalid;
    wire        s_axi_wready;
    wire [1:0]  s_axi_bresp;
    wire        s_axi_bvalid;
    reg         s_axi_bready;
    reg [7:0]   s_axi_araddr;
    reg         s_axi_arvalid;
    wire        s_axi_arready;
    wire [31:0] s_axi_rdata;
    wire [1:0]  s_axi_rresp;
    wire        s_axi_rvalid;
    reg         s_axi_rready;
    
    // Déclaration des signaux d'horloge et de reset
    reg         axi_aclk;
    reg         resetn;

    // Instanciation du module axi
    axi_slave uut (
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

    // Génération de l'horloge
    always
      begin
        #5 axi_aclk <= ~axi_aclk;
      end

    // Génération du reset asynchrone
    initial begin
        #100 resetn <= 0;
        #10 resetn <= 1;
    end

    // Génération des stimuli pour le test
    initial begin
       $dumpfile("axi.vcd");
       $dumpvars;

       axi_aclk <= 0;
       resetn <= 0;
       #10;
       resetn <= 1;

       // Attente pour le reset et la stabilisation initiale
       // Transaction d'écriture
       s_axi_awaddr <= 8'h01;  // Adresse d'écriture
       s_axi_awvalid <= 1;
       s_axi_wdata <= 32'h12345678;  // Données d'écriture
       s_axi_wstrb <= 4'b1111;  // Tous les octets valides
       s_axi_wvalid <= 1;
       s_axi_rready <= 0;
       $monitor("Time=%0t %b s_axi_rdata=%h s_axi_bresp=%h", $time, axi_aclk, s_axi_rdata, s_axi_bresp);
       #10;

        // Attendre que s_axi_awready et s_axi_wready soient valides
       wait (s_axi_awready && s_axi_wready);
       s_axi_awvalid <= 0;
       s_axi_wvalid <= 0;

        // Attendre la réponse d'écriture
       wait (s_axi_bvalid);
        // Vérifier la réponse d'écriture
       if (s_axi_bresp != 2'b00)
          $display("Erreur: Réponse d'écriture incorrecte");

        // Transaction de lecture
       s_axi_araddr <= 8'h01;  // Adresse de lecture
       s_axi_arvalid <= 1;

        // Attendre que s_axi_arready soit valide
       wait (s_axi_arready);
       s_axi_arvalid <= 0;
       s_axi_rready <= 1;

        // Attendre la réponse de lecture
       wait (s_axi_rvalid);
        // Terminer la simulation
       $finish;
    end

endmodule
