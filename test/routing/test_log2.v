module test_log2;

   `include "src/routing/log2.vh"

   initial
     begin
	$display("%d\n", log2(4));
     end
endmodule
