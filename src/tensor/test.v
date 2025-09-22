module test;
   parameter IMG_SIZE = 81;
   parameter DATA_WIDTH = 32;
   reg [IMG_SIZE*DATA_WIDTH-1:0] img;

   parameter			 CONV_SIZE = 9;
   reg [CONV_SIZE*DATA_WIDTH-1:0] kernel;

   wire [(IMG_SIZE*CONV_SIZE)*DATA_WIDTH-1:0] FIFO;
   wire [IMG_SIZE*DATA_WIDTH-1:0] result;

   index #(.result_index(0)) tester(img, kernel, FIFO, result);

   integer i;

   initial
     begin
	$dumpfile("signal_test_tensor.vcd");
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
