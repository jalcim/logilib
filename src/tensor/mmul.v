module mmul(input [SIZE-1:0]  img,
	    input [SIZE-1:0]  kernel,
	    output [SIZE-1:0] result);

   parameter WAY = 9;
   parameter WIRE = 32;
   localparam	  SIZE = WAY * WIRE;

   assign result[WIRE-1:0] = img[WIRE-1:0] * kernel[WIRE-1:0];
   if (WAY > 1)
     mmul #(.WAY(WAY-1), .WIRE(WIRE))recurse(img[SIZE-1:WIRE], kernel[SIZE-1:WIRE], result[SIZE-1:WIRE]);

endmodule

module acc_mul(input [SIZE-1:0]	img,
	       input [SIZE-1:0]	kernel
	       output [31:0]	result);

   parameter WAY = 9;
   parameter WIRE = 32;
   localparam	  SIZE = WAY * WIRE;

   mmul mmul(img, kernel, tmp);
   wire [SIZE-1:0] tmp;
   adder_tree #(.WAY(9), .WIRE(32)) acc(.datain(tmp),
					.dataout(result));
endmodule

/*
module test;
   parameter WAY = 9;
   parameter WIRE = 32;
   localparam	  SIZE = WAY * WIRE;

   reg [SIZE-1:0] img;
   reg [SIZE-1:0] kernel;

   wire [SIZE-1:0] tmp;

   mmul mmul(img, kernel, tmp);

   adder_tree #(.WAY(9), .WIRE(32)) acc(.datain(tmp),
					.dataout(result));

   wire [31:0] result;

   initial
     begin
	img = {32'd1, 32'd2, 32'd4,
	       32'd8, 32'd16, 32'd32,
	       32'd64, 32'd128, 32'd256};

	kernel = {32'd1, 32'd1, 32'd1,
		  32'd1, 32'd1, 32'd1,
		  32'd1, 32'd1, 32'd1};
	#100;
	$display("tmp = %d", tmp[31:0]);
	$display("tmp = %d", tmp[63:32]);
	$display("tmp = %d", tmp[95:64]);
	$display("tmp = %d", tmp[127:96]);
	$display("tmp = %d", tmp[159:128]);
	$display("tmp = %d", tmp[191:160]);
	$display("tmp = %d", tmp[223:192]);
	$display("tmp = %d", tmp[255:224]);
	$display("tmp = %d", tmp[287:256]);

	$display("result = %d\n", result);
     end
endmodule
*/
