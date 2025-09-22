module index(input [IMG_SIZE * DATA_WIDTH -1 : 0]	      img,
	     input [CONV_SIZE * DATA_WIDTH -1 : 0]	      kernel,
	     output [(IMG_SIZE * CONV_SIZE) * DATA_WIDTH -1: 0] FIFO,
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

//donc on a l'information kernel_index
//result_index nous dit dans quel groupe de convolution on est

   wire [31:0] p_img;
   wire [31:0] p_kernel;

   // Signaux temporaires pour regrouper les FIFO selon la position
   wire [4*DATA_WIDTH-1:0] coin_fifo;
   wire [6*DATA_WIDTH-1:0] border_fifo;
   wire [9*DATA_WIDTH-1:0] center_fifo;

   wire [DATA_WIDTH-1:0]   w_result;
   wire [DATA_WIDTH-1:0]   w_fifo;

   if (is_inside)
     begin
	assign p_img = img[PIXEL_START +: DATA_WIDTH];
	assign p_kernel = kernel[KERNEL_START +: DATA_WIDTH];
	assign w_fifo = p_img * p_kernel;
	assign FIFO[FIFO_START +: DATA_WIDTH] = w_fifo;
     end

   if (kernel_index < CONV_SIZE - 1)
     begin
	index #(.result_index(result_index),
		.kernel_index(kernel_index + 1))
	recursive1 (img, kernel, FIFO, result);
//	recursive1 (img, kernel, FIFO[(result_index*CONV_SIZE)*DATA_WITDH +: CONV_SIZE*DATA_WIDTH], result);
     end

   if (kernel_index == 0 && result_index < IMG_SIZE - 1)
     begin
	//ici on ne traite que les result_index donc on peux rassembler tous les fifo de ce result et les additionner
	assign w_result = result[result_index*DATA_WIDTH +: DATA_WIDTH];
	if (is_in_coin)//4
	  begin
	  // Assignation des FIFO pour les coins selon la position
	  if (is_in_top_left)
	    //ne pas mettre les bords gauche et bord haut (exemple si CONV_SIZE==9 exclure 0 1 2 3 6)
	    assign coin_fifo = {FIFO[(result_index*CONV_SIZE+8)*DATA_WIDTH +: DATA_WIDTH],
				FIFO[(result_index*CONV_SIZE+7)*DATA_WIDTH +: DATA_WIDTH],
				FIFO[(result_index*CONV_SIZE+5)*DATA_WIDTH +: DATA_WIDTH],
				FIFO[(result_index*CONV_SIZE+4)*DATA_WIDTH +: DATA_WIDTH]};
	  else if (is_in_top_right)
	    //ne pas mettre les bords droit et bord haut (exemple si CONV_SIZE==9 exclure 2 5 8 et 0 1 2)
	    assign coin_fifo = {FIFO[(result_index*CONV_SIZE+7)*DATA_WIDTH +: DATA_WIDTH],
				FIFO[(result_index*CONV_SIZE+6)*DATA_WIDTH +: DATA_WIDTH],
				FIFO[(result_index*CONV_SIZE+4)*DATA_WIDTH +: DATA_WIDTH],
				FIFO[(result_index*CONV_SIZE+3)*DATA_WIDTH +: DATA_WIDTH]};
	  else if (is_in_bot_left)
	    //ne pas mettre les bords gauche et bord bas (exemple si CONV_SIZE==9 exclure 0 3 6 et 6 7 8)
	    assign coin_fifo = {FIFO[(result_index*CONV_SIZE+5)*DATA_WIDTH +: DATA_WIDTH],
				FIFO[(result_index*CONV_SIZE+4)*DATA_WIDTH +: DATA_WIDTH],
				FIFO[(result_index*CONV_SIZE+2)*DATA_WIDTH +: DATA_WIDTH],
				FIFO[(result_index*CONV_SIZE+1)*DATA_WIDTH +: DATA_WIDTH]};
	  else if (is_in_bot_right)
	    //ne pas mettre les bords droit et bord bas (exemple si CONV_SIZE==9 exclure 2 5 8 et 6 7 8)
	    assign coin_fifo = {FIFO[(result_index*CONV_SIZE+4)*DATA_WIDTH +: DATA_WIDTH],
				FIFO[(result_index*CONV_SIZE+3)*DATA_WIDTH +: DATA_WIDTH],
				FIFO[(result_index*CONV_SIZE+1)*DATA_WIDTH +: DATA_WIDTH],
				FIFO[(result_index*CONV_SIZE+0)*DATA_WIDTH +: DATA_WIDTH]};

	  // Un seul adder_tree pour tous les coins
	  adder_tree #(.WAY(4), .WIRE(DATA_WIDTH))
	     coin_adder(coin_fifo, result[result_index*DATA_WIDTH +: DATA_WIDTH]);
	  end
	else if (is_in_border)//6
	  begin
	  // Assignation des FIFO pour les bordures selon la position
	  if (is_in_border_left)
	    //ne pas mettre le bord gauche (exemple si CONV_SIZE==9 exclure 0 3 6)
	    assign border_fifo = {FIFO[(result_index*CONV_SIZE+8)*DATA_WIDTH +: DATA_WIDTH],
				  FIFO[(result_index*CONV_SIZE+7)*DATA_WIDTH +: DATA_WIDTH],
				  FIFO[(result_index*CONV_SIZE+5)*DATA_WIDTH +: DATA_WIDTH],
				  FIFO[(result_index*CONV_SIZE+4)*DATA_WIDTH +: DATA_WIDTH],
				  FIFO[(result_index*CONV_SIZE+2)*DATA_WIDTH +: DATA_WIDTH],
				  FIFO[(result_index*CONV_SIZE+1)*DATA_WIDTH +: DATA_WIDTH]};
	  else if (is_in_border_right)
	    //ne pas mettre le bord droit (exemple si CONV_SIZE==9 exclure 2 5 8)
	    assign border_fifo = {FIFO[(result_index*CONV_SIZE+7)*DATA_WIDTH +: DATA_WIDTH],
				  FIFO[(result_index*CONV_SIZE+6)*DATA_WIDTH +: DATA_WIDTH],
				  FIFO[(result_index*CONV_SIZE+4)*DATA_WIDTH +: DATA_WIDTH],
				  FIFO[(result_index*CONV_SIZE+3)*DATA_WIDTH +: DATA_WIDTH],
				  FIFO[(result_index*CONV_SIZE+1)*DATA_WIDTH +: DATA_WIDTH],
				  FIFO[(result_index*CONV_SIZE+0)*DATA_WIDTH +: DATA_WIDTH]};
	  else if (is_in_border_top)
	    //ne pas mettre le bord haut (exemple si CONV_SIZE==9 exclure 0 1 2)
	    assign border_fifo = {FIFO[(result_index*CONV_SIZE+8)*DATA_WIDTH +: DATA_WIDTH],
				  FIFO[(result_index*CONV_SIZE+7)*DATA_WIDTH +: DATA_WIDTH],
				  FIFO[(result_index*CONV_SIZE+6)*DATA_WIDTH +: DATA_WIDTH],
				  FIFO[(result_index*CONV_SIZE+5)*DATA_WIDTH +: DATA_WIDTH],
				  FIFO[(result_index*CONV_SIZE+4)*DATA_WIDTH +: DATA_WIDTH],
				  FIFO[(result_index*CONV_SIZE+3)*DATA_WIDTH +: DATA_WIDTH]};
	  else if (is_in_border_bot)
	    //ne pas mettre le bord bas (exemple si CONV_SIZE==9 exclure 6 7 8)
	    assign border_fifo = {FIFO[(result_index*CONV_SIZE+5)*DATA_WIDTH +: DATA_WIDTH],
				  FIFO[(result_index*CONV_SIZE+4)*DATA_WIDTH +: DATA_WIDTH],
				  FIFO[(result_index*CONV_SIZE+3)*DATA_WIDTH +: DATA_WIDTH],
				  FIFO[(result_index*CONV_SIZE+2)*DATA_WIDTH +: DATA_WIDTH],
				  FIFO[(result_index*CONV_SIZE+1)*DATA_WIDTH +: DATA_WIDTH],
				  FIFO[(result_index*CONV_SIZE+0)*DATA_WIDTH +: DATA_WIDTH]};

	  // Un seul adder_tree pour toutes les bordures
	  adder_tree #(.WAY(6), .WIRE(DATA_WIDTH))
	     border_adder(border_fifo, result[result_index*DATA_WIDTH +: DATA_WIDTH]);
	  end
	else//9
	  begin
	     //utiliser tous les kernel taps (exemple si CONV_SIZE==9 utiliser 0 1 2 3 4 5 6 7 8)
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
	  end

	index #(.result_index(result_index + 1),
		.kernel_index(kernel_index))
	recursive2 (img, kernel, FIFO, result);
     end

//   wire [IMG_SIZE*DATA_WIDTH-1:0] result;

endmodule
/*
module test;
   parameter IMG_SIZE = 81;
   parameter DATA_WIDTH = 32;
   reg [IMG_SIZE*DATA_WIDTH-1:0] img;

   parameter			 CONV_SIZE = 9;
   reg [CONV_SIZE*DATA_WIDTH-1:0] kernel;

   wire [(IMG_SIZE*CONV_SIZE)*DATA_WIDTH-1:0] FIFO;
   wire [IMG_SIZE*DATA_WIDTH-1:0] result;

   index #(.result_index(0), .kernel_index(0)) tester(img, kernel, FIFO, result);

   integer i;

   initial
     begin
	$dumpfile("signal_test_tensor4.vcd");
        $dumpvars;
	img = 0;
	kernel = 0;
	#100;
	img <= {32'd00, 32'd01, 32'd02, 32'd03, 32'd04, 32'd05, 32'd06, 32'd07, 32'd08,
		32'd09, 32'd10, 32'd11, 32'd12, 32'd13, 32'd14, 32'd15, 32'd16, 32'd17,
		32'd18, 32'd19, 32'd20, 32'd21, 32'd22, 32'd23, 32'd24, 32'd25, 32'd26,
		32'd27, 32'd28, 32'd29, 32'd30, 32'd31, 32'd32, 32'd33, 32'd34, 32'd35,
		32'd36, 32'd37, 32'd38, 32'd39, 32'd40, 32'd41, 32'd42, 32'd43, 32'd44,
		32'd45, 32'd46, 32'd47, 32'd48, 32'd49, 32'd50, 32'd51, 32'd52, 32'd53,
		32'd54, 32'd55, 32'd56, 32'd57, 32'd58, 32'd59, 32'd60, 32'd61, 32'd62,
		32'd63, 32'd64, 32'd65, 32'd66, 32'd67, 32'd68, 32'd69, 32'd70, 32'd71,
		32'd72, 32'd73, 32'd74, 32'd75, 32'd76, 32'd77, 32'd78, 32'd79, 32'd80};

	kernel <= {32'd00, 32'd01, 32'd02,
		   32'd03, 32'd04, 32'd05,
		   32'd06, 32'd07, 32'd08};
	#100;

	$display("FIFO = \n%x\n", FIFO);
	
	//[result_index][kernel_index]
	//is_inside/coin/border requiert result_index et kernel_index
	$display("result[0] %d", result[0*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[1] %d", result[1*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[2] %d", result[2*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[3] %d", result[3*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[4] %d", result[4*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[5] %d", result[5*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[6] %d", result[6*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[7] %d", result[7*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[8] %d", result[8*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[9] %d", result[9*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[10] %d", result[10*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[11] %d", result[11*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[12] %d", result[12*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[13] %d", result[13*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[14] %d", result[14*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[15] %d", result[15*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[16] %d", result[16*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[17] %d", result[17*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[18] %d", result[18*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[19] %d", result[19*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[20] %d", result[20*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[21] %d", result[21*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[22] %d", result[22*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[23] %d", result[23*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[24] %d", result[24*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[25] %d", result[25*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[26] %d", result[26*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[27] %d", result[27*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[28] %d", result[28*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[29] %d", result[29*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[30] %d", result[30*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[31] %d", result[31*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[32] %d", result[32*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[33] %d", result[33*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[34] %d", result[34*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[35] %d", result[35*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[36] %d", result[36*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[37] %d", result[37*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[38] %d", result[38*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[39] %d", result[39*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[40] %d", result[40*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[41] %d", result[41*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[42] %d", result[42*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[43] %d", result[43*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[44] %d", result[44*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[45] %d", result[45*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[46] %d", result[46*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[47] %d", result[47*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[48] %d", result[48*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[49] %d", result[49*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[50] %d", result[50*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[51] %d", result[51*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[52] %d", result[52*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[53] %d", result[53*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[54] %d", result[54*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[55] %d", result[55*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[56] %d", result[56*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[57] %d", result[57*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[58] %d", result[58*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[59] %d", result[59*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[60] %d", result[60*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[61] %d", result[61*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[62] %d", result[62*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[63] %d", result[63*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[64] %d", result[64*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[65] %d", result[65*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[66] %d", result[66*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[67] %d", result[67*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[68] %d", result[68*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[69] %d", result[69*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[70] %d", result[70*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[71] %d", result[71*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[72] %d", result[72*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[73] %d", result[73*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[74] %d", result[74*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[75] %d", result[75*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[76] %d", result[76*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[77] %d", result[77*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[78] %d", result[78*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[79] %d", result[79*DATA_WIDTH +: DATA_WIDTH]);
	$display("result[80] %d", result[80*DATA_WIDTH +: DATA_WIDTH]);
     end
endmodule
*/
