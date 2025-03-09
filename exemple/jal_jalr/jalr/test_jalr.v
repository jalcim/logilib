`include "exemple/jal_jalr/jalr/jalr.v"

module test_jalr;

    reg [31:0] rs1;
    reg [31:0] imm_i;
    wire [31:0] jal_out;
    wire [31:0] ret;

    jalr jalr_inst (
        .rs1(rs1),
        .imm_i(imm_i),
        .jal_out(jal_out),
        .ret(ret)
    );

    initial begin
        $dumpfile("test_jalr.vcd");
        $dumpvars;
        $display("\t\ttime, \trs1, \t\timm_i, \t\tjal_out, \tret");
        $display("\t\t-----------------------------------------------");
        $monitor("%d \t%h\t%h\t%h\t%h", $time, rs1, imm_i, jal_out, ret);

        rs1 = 32'h1000;
        imm_i = 32'h00001000;
        #100;

        rs1 = 32'h2000;
        imm_i = 32'h00002000;
        #100;

        rs1 = 32'h3000;
        imm_i = 32'hFFF00000;  // Offset négatif
        #100;

        rs1 = 32'h4000;
        imm_i = 32'h00001000;
        #100;
    end
endmodule
