`include "src/alu/logic/sll.v"
`include "src/alu/logic/slt.v"
`include "src/alu/logic/sltu.v"
`include "src/alu/logic/sra_srl.v"

module test_alu_logic;
   parameter WIRE = 32;
   reg [WIRE-1:0] datain_A, datain_B;
   wire [WIRE-1:0] out_sll, out_slt, out_sltu, out_srl;

   sll  #(.WIRE(WIRE)) sll_inst (datain_A, datain_B, out_sll );
   slt  #(.WIRE(WIRE)) slt_inst (datain_A, datain_B, out_slt );
   sltu #(.WIRE(WIRE)) sltu_inst(datain_A, datain_B, out_sltu);
   srl  #(.WIRE(WIRE)) srl_inst (datain_A, datain_B, out_srl );

   initial
     begin
	$dumpfile("signal_sll.vcd");
	$dumpvars;
	$monitor("%d \nA = \t%b \nB = \t%b \nsll = \t%b \nslt = \t%b \nsltu = \t%b \nsrl = \t%b\n",
		 $time, datain_A, datain_B,
		 out_sll, out_slt, out_sltu, out_srl);

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
	datain_A <= 32'b10000000000000000000000000000001;
	datain_B <= 4;
	#100;
     end
endmodule
