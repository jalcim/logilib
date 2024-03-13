`include "exemple/alu/bru/bru.v"

module test_bru;
   reg [31:0] in;
   reg [2:0]  funct3;
   reg	      SIGNAL_bru;

   wire	      SIGNAL_pc;

   bru bru_inst(in, funct3, SIGNAL_bru, SIGNAL_pc);

   initial
     begin
	$dumpfile("signal_bru.vcd");
	$dumpvars;
	$display("\t\ttime, \t\tin, \t\tfunct3, \tbru, \t\tpc");
	$monitor("%d \t%d \t\t%d \t\t%b \t\t%b\n",
		 $time, in, funct3, SIGNAL_bru, SIGNAL_pc);

	SIGNAL_bru <= 1;
	in <= 4-(-5);
	funct3 <= 0;
	$display("beq\n");
	#5;
	funct3 <= 1;
	$display("bne\n");
	#5;
	funct3 <= 4;
	$display("bge\n");
	#5;
	funct3 <= 5;
	$display("blt\n");
	#5;
	funct3 <= 6;
	$display("bgeu\n");
	#5;
	funct3 <= 7;
	$display("bltu\n");
     end
endmodule
