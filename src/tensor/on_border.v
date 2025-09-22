// Assignation des FIFO pour les bordures selon la position
module on_border(input [(IMG_SIZE * CONV_SIZE) * DATA_WIDTH -1: 0] FIFO,
		 output [IMG_SIZE*DATA_WIDTH-1:0]		   result);

   parameter DATA_WIDTH = 32;

   parameter kernel_index = 0;
   parameter result_index = 0;

   parameter CONV_MAX_Y = 3;
   parameter CONV_MAX_X = 3;
   localparam CONV_SIZE = CONV_MAX_Y * CONV_MAX_X;

   parameter  IMG_MAX_Y = 9;
   parameter  IMG_MAX_X = 9;
   localparam IMG_SIZE = IMG_MAX_Y * IMG_MAX_X;

   localparam result_y = result_index / IMG_MAX_X;
   localparam result_x = result_index % IMG_MAX_X;

   localparam is_left = (result_x == 0);
   localparam is_right = result_x == IMG_MAX_X -1;
   localparam is_top = (result_y == 0);
   localparam is_bot = result_y == IMG_MAX_Y -1;

   localparam is_in_border_left = is_left && (!is_top && !is_bot);
   localparam is_in_border_right = is_right && (!is_top && !is_bot);
   localparam is_in_border_top = is_top && (!is_left && !is_right);
   localparam is_in_border_bot = is_bot && (!is_left && !is_right);

   wire [6*DATA_WIDTH-1:0] border_fifo;

   //ne pas mettre le bord gauche (exemple si CONV_SIZE==9 exclure 0 3 6)
   if (is_in_border_left)
     assign border_fifo = {FIFO[(result_index*CONV_SIZE+8)*DATA_WIDTH +: DATA_WIDTH],
			   FIFO[(result_index*CONV_SIZE+7)*DATA_WIDTH +: DATA_WIDTH],
			   FIFO[(result_index*CONV_SIZE+5)*DATA_WIDTH +: DATA_WIDTH],
			   FIFO[(result_index*CONV_SIZE+4)*DATA_WIDTH +: DATA_WIDTH],
			   FIFO[(result_index*CONV_SIZE+2)*DATA_WIDTH +: DATA_WIDTH],
			   FIFO[(result_index*CONV_SIZE+1)*DATA_WIDTH +: DATA_WIDTH]};

   //ne pas mettre le bord droit (exemple si CONV_SIZE==9 exclure 2 5 8)
   else if (is_in_border_right)
     assign border_fifo = {FIFO[(result_index*CONV_SIZE+7)*DATA_WIDTH +: DATA_WIDTH],
			   FIFO[(result_index*CONV_SIZE+6)*DATA_WIDTH +: DATA_WIDTH],
			   FIFO[(result_index*CONV_SIZE+4)*DATA_WIDTH +: DATA_WIDTH],
			   FIFO[(result_index*CONV_SIZE+3)*DATA_WIDTH +: DATA_WIDTH],
			   FIFO[(result_index*CONV_SIZE+1)*DATA_WIDTH +: DATA_WIDTH],
			   FIFO[(result_index*CONV_SIZE+0)*DATA_WIDTH +: DATA_WIDTH]};

   //ne pas mettre le bord haut (exemple si CONV_SIZE==9 exclure 0 1 2)
   else if (is_in_border_top)
     assign border_fifo = {FIFO[(result_index*CONV_SIZE+8)*DATA_WIDTH +: DATA_WIDTH],
			   FIFO[(result_index*CONV_SIZE+7)*DATA_WIDTH +: DATA_WIDTH],
			   FIFO[(result_index*CONV_SIZE+6)*DATA_WIDTH +: DATA_WIDTH],
			   FIFO[(result_index*CONV_SIZE+5)*DATA_WIDTH +: DATA_WIDTH],
			   FIFO[(result_index*CONV_SIZE+4)*DATA_WIDTH +: DATA_WIDTH],
			   FIFO[(result_index*CONV_SIZE+3)*DATA_WIDTH +: DATA_WIDTH]};

   //ne pas mettre le bord bas (exemple si CONV_SIZE==9 exclure 6 7 8)
   else if (is_in_border_bot)
     assign border_fifo = {FIFO[(result_index*CONV_SIZE+5)*DATA_WIDTH +: DATA_WIDTH],
			   FIFO[(result_index*CONV_SIZE+4)*DATA_WIDTH +: DATA_WIDTH],
			   FIFO[(result_index*CONV_SIZE+3)*DATA_WIDTH +: DATA_WIDTH],
			   FIFO[(result_index*CONV_SIZE+2)*DATA_WIDTH +: DATA_WIDTH],
			   FIFO[(result_index*CONV_SIZE+1)*DATA_WIDTH +: DATA_WIDTH],
			   FIFO[(result_index*CONV_SIZE+0)*DATA_WIDTH +: DATA_WIDTH]};

   // Un seul adder_tree pour toutes les bordures
   adder_tree #(.WAY(6), .WIRE(DATA_WIDTH))
   border_adder(border_fifo, result[result_index*DATA_WIDTH +: DATA_WIDTH]);

endmodule
