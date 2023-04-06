module gate_xor(out, in);
   parameter SIZE = 2;
   input [SIZE-1:0] in;
   output 	    out;

   supply1 	    vcc;
   supply0 	    gnd;

   wire 	    line;
   wire [SIZE-1:0]  inv;

   parallel_not #(.SIZE(SIZE))parallel_not(inv[SIZE-1:0], in[SIZE-1:0]);

   serial_pmos #(.SIZE(2)) pmos_array0(out,
				      vcc,
				      {in[0], inv[1]});

   serial_pmos #(.SIZE(2)) pmos_array1(out,
				      vcc,
				      {inv[0], in[1]});

   serial_nmos #(.SIZE(2)) nmos_array0(out,
				      gnd,
				      in[1:0]);

   serial_nmos #(.SIZE(2)) nmos_array1(out,
				      gnd,
				      inv[1:0]);

endmodule // gate_xor
