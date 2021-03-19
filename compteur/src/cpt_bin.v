module cpt_bin8(activate, clk, reset, out);
  input activate, clk, reset;
   output [7:0] out;
   supply1 	power;

   wire   [7:0] line;
   
   
   gate_and and0(activate, clk, line[0]);
   JKlatchUP JK0(power, power, line[0], reset, out[0], line[1]);
   JKlatchUP JK1(power, power, line[1], reset, out[1], line[2]);
   JKlatchUP JK2(power, power, line[2], reset, out[2], line[3]);
   JKlatchUP JK3(power, power, line[3], reset, out[3], line[4]);
   JKlatchUP JK4(power, power, line[4], reset, out[4], line[5]);
   JKlatchUP JK5(power, power, line[5], reset, out[5], line[6]);
   JKlatchUP JK6(power, power, line[6], reset, out[6], line[7]);
   JKlatchUP JK7(power, power, line[7], reset, out[7], z);

endmodule // cpt_bin8
