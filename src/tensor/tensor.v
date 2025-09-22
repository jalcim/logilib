module tensor(input [IMG_SIZE * DATA_WIDTH -1 : 0]		 img,
	      input [CONV_SIZE * DATA_WIDTH -1 : 0]		 kernel,
	      output [(IMG_SIZE * CONV_SIZE) * DATA_WIDTH -1: 0] FIFO,
	      output [IMG_SIZE*DATA_WIDTH-1:0]			 result);

   parameter DATA_WIDTH = 32;

   parameter IMG_MAX_X = 9;
   parameter IMG_MAX_Y = 9;

   parameter CONV_MAX_X = 3;
   parameter CONV_MAX_Y = 3;

   localparam IMG_SIZE = IMG_MAX_Y * IMG_MAX_X;
   localparam CONV_SIZE = CONV_MAX_Y * CONV_MAX_X;

   parameter result_index = 0;
   localparam kernel_index = 0;

   localparam result_y = result_index / IMG_MAX_X;
   localparam kernel_y = kernel_index / CONV_MAX_X;
   localparam img_y = result_y + kernel_y - 1;

   localparam result_x = result_index % IMG_MAX_X;
   localparam kernel_x = kernel_index % CONV_MAX_X;
   localparam img_x = result_x + kernel_x - 1;

   localparam img_index = img_y * IMG_MAX_X + img_x;

   mult #(.DATA_WIDTH(32),
	  .IMG_MAX_Y(IMG_MAX_Y),
	  .IMG_MAX_X(IMG_MAX_X),
	  .CONV_MAX_Y(CONV_MAX_Y),
	  .CONV_MAX_X(CONV_MAX_X),
	  .result_index(result_index),
	  .kernel_index(kernel_index)) mult_stage(img, kernel, FIFO, result);

   if (result_index < IMG_SIZE)
     begin
	acc #(.DATA_WIDTH(32),
	  .IMG_MAX_Y(IMG_MAX_Y),
	  .IMG_MAX_X(IMG_MAX_X),
	  .CONV_MAX_Y(CONV_MAX_Y),
	  .CONV_MAX_X(CONV_MAX_X),
	  .result_index(result_index),
	  .kernel_index(kernel_index)) accumulator(FIFO, result);

	tensor #(.result_index(result_index + 1),
		 .IMG_MAX_X(IMG_MAX_X),
		 .IMG_MAX_Y(IMG_MAX_Y),
		 .CONV_MAX_X(CONV_MAX_X),
		 .CONV_MAX_Y(CONV_MAX_Y),
		 .DATA_WIDTH(DATA_WIDTH)) genblk_tensor (img, kernel, FIFO, result);
     end

endmodule
