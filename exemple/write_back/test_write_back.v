`include "exemple/write_back/write_back.v"
`timescale 1ns/1ps

module write_back_tb;

    reg clk, reset, write_rd_in;
    reg [4:0] rd_in;
    reg [31:0] alu, lui_auipc, jal_jalr, lsu;
    reg signal_lui, signal_auipc, signal_jal, signal_jalr, signal_load;
    reg [31:0] jal_jalr_pc;

    wire [31:0] pc_next;
    wire write_rd_out;
    wire [4:0] rd_out;
    wire [31:0] dataout;

    // Instanciation du module write_back
    write_back uut (
        .clk(clk),
        .reset(reset),
        .write_rd_in(write_rd_in),
        .rd_in(rd_in),
        .alu(alu),
        .lui_auipc(lui_auipc),
        .jal_jalr(jal_jalr),
        .lsu(lsu),
        .signal_lui(signal_lui),
        .signal_auipc(signal_auipc),
        .signal_jal(signal_jal),
        .signal_jalr(signal_jalr),
        .signal_load(signal_load),
        .jal_jalr_pc(jal_jalr_pc),
        .pc_next(pc_next),
        .write_rd_out(write_rd_out),
        .rd_out(rd_out),
        .dataout(dataout)
    );

    // Génération d'une horloge à 100 MHz (10 ns de période)
    always #5 clk = ~clk;

    initial begin
        // Initialisation
        clk = 0;
        reset = 1;
        write_rd_in = 0;
        rd_in = 5'b00010;
        alu = 32'hA5A5A5A5;
        lui_auipc = 32'hBBBBBBBB;
        jal_jalr = 32'hCCCCCCCC;
        lsu = 32'hDDDDDDDD;
        signal_lui = 0;
        signal_auipc = 0;
        signal_jal = 0;
        signal_jalr = 0;
        signal_load = 0;
        jal_jalr_pc = 32'h12345678;

        // Appliquer le reset
        #20 reset = 0;

        // Test 1: ALU en sortie
        #20 signal_lui = 0; signal_auipc = 0; signal_jal = 0; signal_jalr = 0; signal_load = 0;
        #10 if (dataout !== alu) $display("Erreur: ALU attendu, obtenu %h", dataout);

        // Test 2: LUI/AUIPC en sortie
        #20 signal_lui = 1; signal_auipc = 1; signal_jal = 0; signal_jalr = 0; signal_load = 0;
        #10 if (dataout !== lui_auipc) $display("Erreur: LUI/AUIPC attendu, obtenu %h", dataout);

        // Test 3: JAL/JALR en sortie
        #20 signal_lui = 0; signal_auipc = 0; signal_jal = 1; signal_jalr = 1; signal_load = 0;
        #10 if (dataout !== jal_jalr) $display("Erreur: JAL/JALR attendu, obtenu %h", dataout);

        // Test 4: LSU en sortie (LOAD)
        #20 signal_lui = 0; signal_auipc = 0; signal_jal = 0; signal_jalr = 0; signal_load = 1;
        #10 if (dataout !== lsu) $display("Erreur: LSU attendu, obtenu %h", dataout);

        // Test 5: Vérification de pc_next
        #10 if (pc_next !== (jal_jalr_pc | alu)) $display("Erreur: pc_next attendu, obtenu %h", pc_next);

        // Fin de la simulation
        #50;
        $finish;
    end

    // Capture des signaux pour analyse avec GTKWave
    initial begin
        $dumpfile("write_back_tb.vcd");
        $dumpvars(0, write_back_tb);
    end

endmodule
