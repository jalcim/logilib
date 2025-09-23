`ifndef __ON_CENTER__
 `define __ON_CENTER__

 `include "src/tensor/adder_tree.v"

//utiliser tous les kernel taps (exemple si CONV_SIZE==9 utiliser 0 1 2 3 4 5 6 7 8)
module on_center(input [(IMG_SIZE * CONV_SIZE) * DATA_WIDTH -1: 0] FIFO,
		 output [IMG_SIZE*DATA_WIDTH-1:0]		   result);

   parameter DATA_WIDTH = 32;

   parameter result_index = 0;

   parameter CONV_MAX_Y = 3;
   parameter CONV_MAX_X = 3;
   localparam CONV_SIZE = CONV_MAX_Y * CONV_MAX_X;

   parameter  IMG_MAX_Y = 9;
   parameter  IMG_MAX_X = 9;
   localparam IMG_SIZE = IMG_MAX_Y * IMG_MAX_X;

   adder_tree #(.WAY(9), .WIRE(DATA_WIDTH))
   center_adder({FIFO[(result_index*CONV_SIZE+8)*DATA_WIDTH +: DATA_WIDTH],
		 FIFO[(result_index*CONV_SIZE+7)*DATA_WIDTH +: DATA_WIDTH],
		 FIFO[(result_index*CONV_SIZE+6)*DATA_WIDTH +: DATA_WIDTH],
		 FIFO[(result_index*CONV_SIZE+5)*DATA_WIDTH +: DATA_WIDTH],
		 FIFO[(result_index*CONV_SIZE+4)*DATA_WIDTH +: DATA_WIDTH],
		 FIFO[(result_index*CONV_SIZE+3)*DATA_WIDTH +: DATA_WIDTH],
		 FIFO[(result_index*CONV_SIZE+2)*DATA_WIDTH +: DATA_WIDTH],
		 FIFO[(result_index*CONV_SIZE+1)*DATA_WIDTH +: DATA_WIDTH],
		 FIFO[(result_index*CONV_SIZE+0)*DATA_WIDTH +: DATA_WIDTH]},
		result[result_index*DATA_WIDTH +: DATA_WIDTH]);
endmodule

`endif
