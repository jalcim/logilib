module double(input	    clk,
	      input	    rst,
	      input	    write,

	      input [51:0]  mantissa_in,
	      input [10:0]  exponent_in,
	      input	    sign_in,

	      output [51:0] mantissa_out,
	      output [10:0] exponent_out,
	      output	    sign_out);

   wire [63:0] D = {sign_in, exponent_in, mantissa_in};
   wire [63:0] Q, QN;
   wire	       en = clk & write;

   Dlatch_rst #(.WAY(81), .WIRE(64)) picture(.D(D),
					     .clk(en),
					     .rst(rst),
					     .Q(Q),
					     .QN(QN));

   assign {sign_out, exponent_out, mantissa_out} = {Q[63], Q[62:52], Q[51:0]};

endmodule
