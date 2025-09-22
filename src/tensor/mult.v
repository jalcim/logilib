module mult(input [IMG_SIZE * DATA_WIDTH -1 : 0]	       img,
	    input [CONV_SIZE * DATA_WIDTH -1 : 0]	       kernel,
	    output [(IMG_SIZE * CONV_SIZE) * DATA_WIDTH -1: 0] FIFO,
	    //	     output [FIFO_KERNEL_SIZE-1:0]			FIFO,
	    output [IMG_SIZE*DATA_WIDTH-1:0]		       result);

   parameter DATA_WIDTH = 32;
   parameter IMG_MAX_Y = 9;
   parameter IMG_MAX_X = 9;
   parameter CONV_MAX_Y = 3;
   parameter CONV_MAX_X = 3;
   parameter result_index = 0;
   parameter kernel_index = 0;

   localparam IMG_SIZE = IMG_MAX_Y * IMG_MAX_X;
   localparam CONV_SIZE = CONV_MAX_Y * CONV_MAX_X;
   localparam result_y = result_index / IMG_MAX_X;
   localparam result_x = result_index % IMG_MAX_X;
   localparam kernel_y = kernel_index / CONV_MAX_X;
   localparam kernel_x = kernel_index % CONV_MAX_X;
   localparam img_y = result_y + kernel_y - 1;
   localparam img_x = result_x + kernel_x - 1;
   
   localparam is_inside = (img_y >= 0 && img_y < IMG_MAX_Y
			   &&
			   img_x >= 0 && img_x < IMG_MAX_X);

   localparam img_index = img_y * IMG_MAX_X + img_x;
   localparam PIXEL_START = img_index*DATA_WIDTH;
   localparam KERNEL_START = kernel_index*DATA_WIDTH;

   localparam fifo_index = (result_index*CONV_SIZE)+kernel_index;
   localparam FIFO_START = fifo_index * DATA_WIDTH;

   wire [DATA_WIDTH-1:0] w_img;
   wire [DATA_WIDTH-1:0] w_kernel;
   wire [DATA_WIDTH-1:0] w_fifo;

   if (is_inside)
     begin
	assign w_img = img[PIXEL_START +: DATA_WIDTH];
	assign w_kernel = kernel[KERNEL_START +: DATA_WIDTH];
	assign w_fifo = w_img * w_kernel;
	assign FIFO[FIFO_START +: DATA_WIDTH] = w_fifo;
	//	assign FIFO[DATA_WIDTH: 0] = w_fifo;
     end

   if (kernel_index < CONV_SIZE - 1)
     begin
	   mult #(.DATA_WIDTH(32),
	  .IMG_MAX_Y(IMG_MAX_Y),
	  .IMG_MAX_X(IMG_MAX_X),
	  .CONV_MAX_Y(CONV_MAX_Y),
	  .CONV_MAX_X(CONV_MAX_X),
	  .result_index(result_index),
	  .kernel_index(kernel_index+1)) mult_stage(img, kernel, FIFO, result);
/*
	index #(.result_index(result_index),
		.kernel_index(kernel_index + 1))
	mult (img, kernel, FIFO, result);
*/	//	resursive1 (img, kernel, FIFO[FIFO_KERNEL_START:FIFO_KERNEL_END], result);
     end


endmodule
