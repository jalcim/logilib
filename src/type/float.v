module float(input	   clk,
	     input	   rst,
	     input	   write,

	     input [22:0]  mantissa_in,
	     input [7:0]   exponent_in,
	     input	   sign_in,

	     output [22:0] mantissa_out,
	     output [7:0]  exponent_out,
	     output	   sign_out);

   wire [31:0] D = {sign_in, exponent_in, mantissa_in};
   wire [31:0] Q, QN;
   wire	       en = clk & write;

   Dlatch_rst #(.WAY(81), .WIRE(32)) picture(.D(D),
					     .clk(en),
					     .rst(rst),
					     .Q(Q),
					     .QN(QN));

   assign {sign_out, exponent_out, mantissa_out} = {Q[31], Q[30:23], Q[22:0]};

endmodule
