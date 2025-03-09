`include "exemple/jal_jalr/jal/jal.v"

module test_jal;

    reg [31:0] pc;
    reg [31:0] imm_j;
    wire [31:0] jal_out;
    wire [31:0] ret;

    jal jal_inst (
        .pc(pc),
        .imm_j(imm_j),
        .jal_out(jal_out),
        .ret(ret)
    );

    initial begin
        $dumpfile("test_jal.vcd");
        $dumpvars;
        $display("\t\ttime, \tpc, \t\timm_j, \t\tjal_out, \tret");
        $display("\t\t-----------------------------------------------");
        $monitor("%d \t%h\t%h\t%h\t%h", $time, pc, imm_j, jal_out, ret);

        pc = 32'h1000;
        imm_j = 32'h00001000;
        #100;

        pc = 32'h2000;
        imm_j = 32'h00002000;
        #100;

        pc = 32'h3000;
        imm_j = 32'hFFF00000;  // Offset négatif
        #100;

        pc = 32'h4000;
        imm_j = 32'h00001000;
        #100;
    end
endmodule
