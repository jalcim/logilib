module gate_and(out, in);
   parameter SIZE = 2;
   input [SIZE-1:0] in;
   output	    out;

   supply1	    vcc;
   supply0	    gnd;

   wire line;

   parallel_pmos #(.SIZE(2)) pmos_array({line, line},
					{SIZE{vcc}},
					in);

   serial_nmos #(.SIZE(2)) nmos_array(line,
				      gnd,
				      in);

   gate_not invout(out, line);

endmodule
