`include "exemple/lsu/mux_load.v"

module test_mux_load;
   reg [31:0] mem;
   reg [2:0]  funct3;
   wire [31:0] dataout;

   mux_load mux_load_inst (mem, funct3, dataout);

   initial
     begin
	$dumpfile("test_mux_load.vcd");
        $dumpvars;
        $display("\t\ttime, \tmem, \tfunct3, \tdataout");
        $display("\t\t-----------------------------------------");
        $monitor("%d \t%x\t%b\t%x", $time, mem, funct3, dataout);

	mem <= 0;
	funct3 <= 3'b000;

	#100;

	mem <= 32'hffffffff;
	funct3 <= 3'b000;//lb

	#100;

	funct3 <= 3'b001;//lh

	#100;

	funct3 <= 3'b010;//lw

	#100;

	mem <= 32'h0000000f;
	funct3 <= 3'b100;//lh

	#100;

	mem <= 32'h00000fff;
	funct3 <= 3'b101;//lw

	#100;
	mem <= 32'h000000ff;	
	funct3 <= 3'b100;//lh

	#100;

	mem <= 32'h0000ffff;
	funct3 <= 3'b101;//lw

	#100;
     end
endmodule
