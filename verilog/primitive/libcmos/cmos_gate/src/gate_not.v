module gate_not(out, in);
   input in;
   output out;
   supply1 vcc;
   supply0 gdd;

   pmos pmos0(out, vcc, in);
   nmos nmos0(out, gdd, in);

endmodule
