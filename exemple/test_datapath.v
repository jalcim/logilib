`timescale 1ns/1ps

`include "exemple/datapath.v"

module riscv_datapath_tb;

    reg reset;
    reg active;
    reg extern_clk;
    
    // Instance du datapath
   riscv_datapath #(.SIZE_ADDR_REG(8),
		    .SIZE_REG(32))
   uut (
        .reset(reset),
        .active(active),
        .extern_clk(extern_clk)
	);

    // Génération d'une horloge à 100 MHz (période 10 ns)
    always #100 extern_clk = ~extern_clk;

    initial begin
        // Initialisation des signaux
        extern_clk = 0;
        reset = 1;
        active = 0;
        
        // Attendre un peu avant de relâcher le reset
        #500;
        reset = 0;
        active = 1;

        // Exécuter la simulation pour 10 secondes (10 000 000 000 ns)
        #10000;

        // Fin de simulation
        $finish;
    end

    // Capture de la simulation
    initial begin
        $dumpfile("riscv_datapath_tb.vcd");
        $dumpvars;
    end

endmodule
