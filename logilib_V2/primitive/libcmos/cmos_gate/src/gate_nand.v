module gate_nand(out, in);
   parameter SIZE = 2;
   input [SIZE-1:0] in;
   output	    out;

   supply1	    vcc;
   supply0	    gnd;

   parallel_pmos #(.SIZE(2)) pmos_array({out, out},
					{SIZE{vcc}},
					in);
				      
   serial_nmos #(.SIZE(2)) nmos_array(out,
				      gnd,
				      in);
endmodule
