`include "exemple/lsu/mux_store.v"

module test_mux_store;
   reg [31:0] mem;
   reg [2:0]  funct3;
   wire [31:0] dataout;

   mux_store mux_store_inst (mem, funct3, dataout);

   initial
     begin
	$dumpfile("test_mux_store.vcd");
        $dumpvars;
        $display("\t\ttime, \tmem, \tfunct3, \tdataout");
        $display("\t\t-----------------------------------------");
        $monitor("%d \t%x\t%b\t%x", $time, mem, funct3, dataout);

	mem <= 0;
	funct3 <= 3'b000;

	#100;

	mem <= 32'hffffffff;
	funct3 <= 3'b000;//sb

	#100;

	funct3 <= 3'b001;//sh

	#100;

	funct3 <= 3'b010;//sw

	#100;
     end
endmodule
