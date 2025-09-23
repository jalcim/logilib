`ifndef __ACC__
 `define __ACC__

 `include "src/tensor/on_coin.v"
 `include "src/tensor/on_border.v"
 `include "src/tensor/on_center.v"

module acc(input [(IMG_SIZE * CONV_SIZE) * DATA_WIDTH -1: 0] FIFO,
	   output [IMG_SIZE*DATA_WIDTH-1:0]		     result);

   parameter DATA_WIDTH = 32;

   parameter kernel_index = 0;
   parameter result_index = 0;

   parameter CONV_MAX_Y = 3;
   parameter CONV_MAX_X = 3;
   localparam CONV_SIZE = CONV_MAX_Y * CONV_MAX_X;

   parameter  IMG_MAX_Y = 9;
   parameter  IMG_MAX_X = 9;
   localparam IMG_SIZE = IMG_MAX_Y * IMG_MAX_X;

   localparam result_x = result_index % IMG_MAX_X;
   localparam result_y = result_index / IMG_MAX_X;

   localparam is_left = (result_x == 0);
   localparam is_right = result_x == IMG_MAX_X -1;
   localparam is_top = (result_y == 0);
   localparam is_bot = result_y == IMG_MAX_Y -1;

   localparam is_in_top_left = (is_top && is_left);
   localparam is_in_top_right = (is_top && is_right);
   localparam is_in_bot_left = (is_bot && is_left);
   localparam is_in_bot_right = (is_bot && is_right);
   
   localparam is_in_coin =
	      is_in_top_left
	      | is_in_top_right
	      | is_in_bot_left
	      | is_in_bot_right;

   localparam is_in_border_left = is_left && (!is_top && !is_bot);
   localparam is_in_border_right = is_right && (!is_top && !is_bot);
   localparam is_in_border_top = is_top && (!is_left && !is_right);
   localparam is_in_border_bot = is_bot && (!is_left && !is_right);

   localparam is_in_border =
	      is_in_border_top
	      | is_in_border_bot
	      | is_in_border_left
	      | is_in_border_right;

   if (is_in_coin)//4
     begin
	on_coin #(.DATA_WIDTH(DATA_WIDTH),
		  .kernel_index(kernel_index),
		  .result_index(result_index),
		  .CONV_MAX_Y(CONV_MAX_Y),
		  .CONV_MAX_X(CONV_MAX_X),
		  .IMG_MAX_Y(IMG_MAX_Y),
		  .IMG_MAX_X(IMG_MAX_X)) adder_coin(FIFO, result);
     end
   else if (is_in_border)//6
     begin
	on_border #(.DATA_WIDTH(DATA_WIDTH),
		    .kernel_index(kernel_index),
		    .result_index(result_index),
		    .CONV_MAX_Y(CONV_MAX_Y),
		    .CONV_MAX_X(CONV_MAX_X),
		    .IMG_MAX_Y(IMG_MAX_Y),
		    .IMG_MAX_X(IMG_MAX_X)) adder_border(FIFO, result);
     end
   else//9
     begin
	on_center #(.DATA_WIDTH(DATA_WIDTH),
		    .result_index(result_index),
		    .CONV_MAX_Y(CONV_MAX_Y),
		    .CONV_MAX_X(CONV_MAX_X),
		    .IMG_MAX_Y(IMG_MAX_Y),
		    .IMG_MAX_X(IMG_MAX_X)) adder_center(FIFO, result);
     end

endmodule

`endif
