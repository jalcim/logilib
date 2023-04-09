module gate_or(out, in);
   parameter SIZE = 2;
   input [SIZE-1:0] in;
   output	    out;

   supply1	    vcc;
   supply0	    gnd;

   wire line;

   serial_pmos #(.SIZE(2)) pmos_array(line,
				      vcc,
				      in);

   parallel_nmos #(.SIZE(2)) nmos_array({line, line},
					{SIZE{gnd}},
					in);

   gate_not invout(out, line);

endmodule
