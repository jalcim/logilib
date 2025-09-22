module index(input [IMG_SIZE * DATA_WIDTH -1 : 0]		img,
	     input [CONV_SIZE * DATA_WIDTH -1 : 0]		kernel,
	     output [(IMG_SIZE * CONV_SIZE) * DATA_WIDTH -1: 0]	FIFO,
//	     output [FIFO_KERNEL_SIZE-1:0]			FIFO,
	     output [IMG_SIZE*DATA_WIDTH-1:0]		      result);

   parameter DATA_WIDTH = 32;

   parameter IMG_MAX_X = 9;
   parameter IMG_MAX_Y = 9;

   parameter CONV_MAX_X = 3;
   parameter CONV_MAX_Y = 3;

   localparam IMG_SIZE = IMG_MAX_Y * IMG_MAX_X;
   localparam CONV_SIZE = CONV_MAX_Y * CONV_MAX_X;

////////////////////////////////////////////////////////////
   parameter result_index = 0;
   parameter kernel_index = 0;

   localparam result_y = result_index / IMG_MAX_X;
   localparam kernel_y = kernel_index / CONV_MAX_X;
   localparam img_y = result_y + kernel_y - 1;

   localparam result_x = result_index % IMG_MAX_X;
   localparam kernel_x = kernel_index % CONV_MAX_X;
   localparam img_x = result_x + kernel_x - 1;

   localparam img_index = img_y * IMG_MAX_X + img_x;

////////////////////////////////////////////////////////////

   localparam is_inside = (img_y >= 0 && img_y < IMG_MAX_Y
			   &&
			   img_x >= 0 && img_x < IMG_MAX_X);

   localparam is_left = (result_x == 0);
   localparam is_right = result_x == IMG_MAX_X -1;
   localparam is_top = (result_y == 0);
   localparam is_bot = result_y == IMG_MAX_Y -1;

   localparam is_in_coin =
	      is_in_top_left
	      | is_in_top_right
	      | is_in_bot_left
	      | is_in_bot_right;

   localparam is_in_top_left = (is_top && is_left);
   localparam is_in_top_right = (is_top && is_right);
   localparam is_in_bot_left = (is_bot && is_left);
   localparam is_in_bot_right = (is_bot && is_right);

   localparam is_in_border =
	      is_in_border_top
	      | is_in_border_bot
	      | is_in_border_left
	      | is_in_border_right;

   localparam is_in_border_left = is_left && (!is_top && !is_bot);
   localparam is_in_border_right = is_right && (!is_top && !is_bot);
   localparam is_in_border_top = is_top && (!is_left && !is_right);
   localparam is_in_border_bot = is_bot && (!is_left && !is_right);

////////////////////////////////////////////////////////////

   localparam PIXEL_START = img_index*DATA_WIDTH;
   localparam KERNEL_START = kernel_index*DATA_WIDTH;

   localparam fifo_index = (result_index*CONV_SIZE)+kernel_index;
   localparam FIFO_START = fifo_index * DATA_WIDTH;

   localparam fifo_kernel_start = ((result_index)*CONV_SIZE)+(kernel_index+1);
   localparam FIFO_KERNEL_START = fifo_kernel_start * DATA_WIDTH;

   localparam fifo_kernel_end = ((result_index)*CONV_SIZE)+(kernel_index+1)+(CONV_SIZE - kernel_index);
   localparam FIFO_KERNEL_END = fifo_kernel_end * DATA_WIDTH;

   localparam fifo_kernel_size = (CONV_SIZE - kernel_index);
   localparam FIFO_KERNEL_SIZE = fifo_kernel_size * DATA_WIDTH;

//donc on a l'information kernel_index
//result_index nous dit dans quel groupe de convolution on est

   wire [31:0] w_img;
   wire [31:0] w_kernel;

   // Signaux temporaires pour regrouper les FIFO selon la position
   wire [9*DATA_WIDTH-1:0] center_fifo;

   wire [DATA_WIDTH-1:0]   w_fifo;

   mult #(.DATA_WIDTH(32),
	  .IMG_MAX_Y(IMG_MAX_Y),
	  .IMG_MAX_X(IMG_MAX_X),
	  .CONV_MAX_Y(CONV_MAX_Y),
	  .CONV_MAX_X(CONV_MAX_X),
	  .result_index(result_index),
	  .kernel_index(kernel_index)) mult_stage(img, kernel, FIFO, result);

   if (kernel_index == 0 && result_index < IMG_SIZE)
     begin//ici on ne traite que les result_index donc on peux rassembler tous les fifo de ce result et les additionner
	acc #(.DATA_WIDTH(32),
	  .IMG_MAX_Y(IMG_MAX_Y),
	  .IMG_MAX_X(IMG_MAX_X),
	  .CONV_MAX_Y(CONV_MAX_Y),
	  .CONV_MAX_X(CONV_MAX_X),
	  .result_index(result_index),
	  .kernel_index(kernel_index)) accumulator(FIFO, result);

	index #(.result_index(result_index + 1),
		.kernel_index(kernel_index))
	recursive2 (img, kernel, FIFO, result);
     end

endmodule
