`include "exemple/jal_jalr/jal_jalr.v"

module test_jal_jalr;

    reg [31:0] pc_in;
    reg [31:0] imm;
    reg [31:0] rs1;
    reg signal_jalr;
    wire signal_pc;
    wire [31:0] pc_out;
    wire [31:0] ret;

    jal_jalr jal_jalr_inst (
        .pc_in(pc_in),
        .imm(imm),
        .rs1(rs1),
        .signal_jalr(signal_jalr),
        .signal_pc(signal_pc),
        .pc_out(pc_out),
        .ret(ret)
    );

    initial begin
        $dumpfile("test_jal_jalr.vcd");
        $dumpvars;
        $display("\t\ttime, \tpc_in, \t\timm, \t\trs1, \tsignal_jalr, \tpc_out, \tret");
        $display("\t---------------------------------------------------------------");
        $monitor("%d \t%h \t%h \t%h \t%b \t%h \t%h", $time, pc_in, imm, rs1, signal_jalr, pc_out, ret);

        // Test 1: JAL avec signal_jalr = 0 (jal)
        pc_in = 32'h1000;
        imm = 32'h00001000;
        rs1 = 32'h0;
        signal_jalr = 0;
        #10;

        // Test 2: JALR avec signal_jalr = 1 (jalr)
        pc_in = 32'h2000;
        imm = 32'h00001000;
        rs1 = 32'h3000;
        signal_jalr = 1;
        #10;

        // Test 3: JAL avec un offset négatif
        pc_in = 32'h4000;
        imm = 32'hFFF00000;
        rs1 = 32'h0;
        signal_jalr = 0;
        #10;

        // Test 4: JALR avec un autre offset
        pc_in = 32'h5000;
        imm = 32'h00002000;
        rs1 = 32'h7000;
        signal_jalr = 1;
        #10;

        // Test 5: JAL avec offset nul
        pc_in = 32'h6000;
        imm = 32'h00000000;
        rs1 = 32'h0;
        signal_jalr = 0;
        #10;

        // Test 6: JALR avec signal_jalr = 1 et un autre offset
        pc_in = 32'h7000;
        imm = 32'h00001000;
        rs1 = 32'h0;
        signal_jalr = 1;
        #10;

        // Test 7: JAL avec un offset nul et signal_jalr = 0
        pc_in = 32'h8000;
        imm = 32'h00000000;
        rs1 = 32'h0;
        signal_jalr = 0;
        #10;

        // Test 8: JAL avec un offset positif
        pc_in = 32'h9000;
        imm = 32'h00001000;
        rs1 = 32'h0;
        signal_jalr = 0;
        #10;

        // Test 9: JALR avec un petit offset et signal_jalr = 1
        pc_in = 32'hA000;
        imm = 32'h00000400;
        rs1 = 32'hB000;
        signal_jalr = 1;
        #10;

        // Test 10: JALR avec un grand offset et signal_jalr = 1
        pc_in = 32'hC000;
        imm = 32'hFFF00000;
        rs1 = 32'hD000;
        signal_jalr = 1;
        #10;

        // Test 11: Test avec signal_jalr = 0 (jal) et une grande valeur pour imm
        pc_in = 32'hE000;
        imm = 32'hFFF00000;
        rs1 = 32'h0;
        signal_jalr = 0;
        #10;

        // Test 12: Test avec signal_jalr = 1 (jalr) et imm négatif
        pc_in = 32'hF000;
        imm = 32'hFFFFF800;
        rs1 = 32'h5000;
        signal_jalr = 1;
        #10;

        // Test 13: Test avec des valeurs maximales
        pc_in = 32'hFFFFFFFF;
        imm = 32'hFFFFFFFF;
        rs1 = 32'hFFFFFFFF;
        signal_jalr = 1;
        #10;

        $finish;
    end

endmodule
