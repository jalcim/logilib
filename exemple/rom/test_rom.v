`include "rom.v"

module test;

   reg [31:0] pc;
   wire [31:0] opcode;

   rom tareum(pc, opcode);

   initial
     begin
	#100;
	pc = 0;
	$display("%b\t%d", opcode, pc);
	#100;
	pc = 1;
	$display("%b\t%d", opcode, pc);
	#100;
	pc = 2;
	$display("%b\t%d", opcode, pc);
	#100;

     end
endmodule
