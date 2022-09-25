module gate_nand(out, e1, e2);
   parameter SIZE = 1;
   input [SIZE-1:0] e1, e2;
   output	    out;

   supply1	    vcc;
   supply0	    gnd;

   wire	[0:0]	    line;

   serial_pmos #(.SIZE(2)) pmos_array({out, out},
				      {vcc, vcc},
				      {e1[0], e2[0]});
   serial_nmos #(.SIZE(2)) nmos_array({line[0], out},
				      {gnd, line[0]},
				      {e1[0], e2[0]});
endmodule
