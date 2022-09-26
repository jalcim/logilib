module gate_nand(out, e1);
   parameter SIZE = 2;
   input [SIZE-1:0] e1;
   output	    out;

   supply1	    vcc;
   supply0	    gnd;

   wire [SIZE-2:0]  line;

   serial_pmos #(.SIZE(2)) pmos_array({out, out},
				      {SIZE{vcc}},
				      e1);
   serial_nmos #(.SIZE(2)) nmos_array({line, out},
				      {gnd, line},
				      e1);
endmodule
