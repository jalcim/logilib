module cpt_bin8(activate, clk, reset, out);
  input activate, clk, reset;
   output out;
   wire   power;
   assign power = 1;

   wire   line;
   
   
   gate_and and0(activate, clk, line[0]);
   Tlatch Dff0(power, );

 endmodule // cpt_bin8
