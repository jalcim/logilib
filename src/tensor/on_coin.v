`ifndef __ON_COIN__
 `define __ON_COIN__

 `include "src/tensor/adder_tree.v"

// Assignation des FIFO pour les coins selon la position
module on_coin(input [(IMG_SIZE * CONV_SIZE) * DATA_WIDTH -1: 0] FIFO,
	       output [IMG_SIZE*DATA_WIDTH-1:0]			 result);

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

   localparam is_in_top_left = (is_top && is_left);
   localparam is_in_top_right = (is_top && is_right);
   localparam is_in_bot_left = (is_bot && is_left);
   localparam is_in_bot_right = (is_bot && is_right);

   wire [4*DATA_WIDTH-1:0] coin_fifo;

   //ne pas mettre les bords gauche et bord haut (exemple si CONV_SIZE==9 exclure 0 1 2 3 6)
   if (is_in_top_left)
     assign coin_fifo = {FIFO[(result_index*CONV_SIZE+8)*DATA_WIDTH +: DATA_WIDTH],
			 FIFO[(result_index*CONV_SIZE+7)*DATA_WIDTH +: DATA_WIDTH],
			 FIFO[(result_index*CONV_SIZE+5)*DATA_WIDTH +: DATA_WIDTH],
			 FIFO[(result_index*CONV_SIZE+4)*DATA_WIDTH +: DATA_WIDTH]};

   //ne pas mettre les bords droit et bord haut (exemple si CONV_SIZE==9 exclure 2 5 8 et 0 1 2)
   else if (is_in_top_right)
     assign coin_fifo = {FIFO[(result_index*CONV_SIZE+7)*DATA_WIDTH +: DATA_WIDTH],
			 FIFO[(result_index*CONV_SIZE+6)*DATA_WIDTH +: DATA_WIDTH],
			 FIFO[(result_index*CONV_SIZE+4)*DATA_WIDTH +: DATA_WIDTH],
			 FIFO[(result_index*CONV_SIZE+3)*DATA_WIDTH +: DATA_WIDTH]};

   //ne pas mettre les bords gauche et bord bas (exemple si CONV_SIZE==9 exclure 0 3 6 et 6 7 8)
   else if (is_in_bot_left)
     assign coin_fifo = {FIFO[(result_index*CONV_SIZE+5)*DATA_WIDTH +: DATA_WIDTH],
			 FIFO[(result_index*CONV_SIZE+4)*DATA_WIDTH +: DATA_WIDTH],
			 FIFO[(result_index*CONV_SIZE+2)*DATA_WIDTH +: DATA_WIDTH],
			 FIFO[(result_index*CONV_SIZE+1)*DATA_WIDTH +: DATA_WIDTH]};

   //ne pas mettre les bords droit et bord bas (exemple si CONV_SIZE==9 exclure 2 5 8 et 6 7 8)
   else if (is_in_bot_right)
     assign coin_fifo = {FIFO[(result_index*CONV_SIZE+4)*DATA_WIDTH +: DATA_WIDTH],
			 FIFO[(result_index*CONV_SIZE+3)*DATA_WIDTH +: DATA_WIDTH],
			 FIFO[(result_index*CONV_SIZE+1)*DATA_WIDTH +: DATA_WIDTH],
			 FIFO[(result_index*CONV_SIZE+0)*DATA_WIDTH +: DATA_WIDTH]};

   // Un seul adder_tree pour tous les coins
   adder_tree #(.WAY(4), .WIRE(DATA_WIDTH))
   coin_adder(coin_fifo, result[result_index*DATA_WIDTH +: DATA_WIDTH]);

endmodule

`endif
