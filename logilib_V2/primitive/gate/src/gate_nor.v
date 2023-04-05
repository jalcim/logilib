module gate_nor(out, in);
   parameter SIZE = 2;
   input [SIZE-1:0] in;
   output	    out;

   supply1	    vcc;
   supply0	    gnd;

   wire	[0:0]	    line;

   serial_pmos #(.SIZE(2)) pmos_array(out,
				      vcc,
				      in);

   parallel_nmos #(.SIZE(2)) nmos_array({out, out},
					{SIZE{gnd}},
					in);

endmodule
