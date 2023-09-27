`include "src/alu/logic/sll.v"
`include "src/alu/logic/slt.v"
`include "src/alu/logic/sltu.v"
`include "src/alu/logic/sra_srl.v"

module test_alu_logic;
   parameter WIRE = 32;
   reg [WIRE-1:0] datain_A, datain_B;
   wire [WIRE-1:0] out_sll, out_slt, out_sltu, out_srl, out_sra;

   sll  #(.WIRE(WIRE)) sll_inst (datain_A, datain_B, out_sll );
   slt  #(.WIRE(WIRE)) slt_inst (datain_A, datain_B, out_slt );
   sltu #(.WIRE(WIRE)) sltu_inst(datain_A, datain_B, out_sltu);
   sra_srl  #(.WIRE(WIRE)) srl_inst (1'b1, datain_A, datain_B, out_srl );
   sra_srl  #(.WIRE(WIRE)) sra_inst (1'b0, datain_A, datain_B, out_sra );

   initial
     begin
	$dumpfile("signal_alu_logic.vcd");
	$dumpvars;
	$monitor("%d \nA = \t%b \nB = \t%b \nsll = \t%b \nslt = \t%b \nsltu = \t%b \nsrl = \t%b\nsra = \t%b\n",
		 $time, datain_A, datain_B,
		 out_sll, out_slt, out_sltu, out_srl, out_sra);

	datain_A <= 0;
	datain_B <= 0;
	#100;
	datain_A <= 4;
	datain_B <= 0;
	#100;
	datain_A <= 4;
	datain_B <= 1;
	#100;
	datain_A <= 4;
	datain_B <= 2;
	#100;
	datain_A <= 4;
	datain_B <= 3;
	#100;
	datain_A <= 4;
	datain_B <= 4;
	#100;
	datain_A <= 4;
	datain_B <= 5;
	#100;
	datain_A <= 4;
	datain_B <= 32'b10000000000000000000000000000001;
	#100;
	datain_A <= 32'b10000000000000000000000000000010;
	datain_B <= 1;
	#100;
     end
endmodule
