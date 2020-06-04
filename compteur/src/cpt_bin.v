module cpt_bin8(activate, clk, reset, out);
  input activate, clk, reset;
   output [7:0] out;
   wire   power;
   assign power = 1;

   wire   [7:0] line;
   
   
   gate_and and0(activate, clk, line[0]);
   JKlatchUP JK0(power, power, reset, line[0], out[0], line[1]);
   JKlatchUP JK1(power, power, reset, line[1], out[1], line[2]);
   JKlatchUP JK2(power, power, reset, line[2], out[2], line[3]);
   JKlatchUP JK3(power, power, reset, line[3], out[3], line[4]);
   JKlatchUP JK4(power, power, reset, line[4], out[4], line[5]);
   JKlatchUP JK5(power, power, reset, line[5], out[5], line[6]);
   JKlatchUP JK6(power, power, reset, line[6], out[6], line[7]);
   JKlatchUP JK7(power, power, reset, line[7], out[7], z);

endmodule // cpt_bin8
