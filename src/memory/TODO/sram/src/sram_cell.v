module sram_cell(data_out, data_in, select);
   input  [1:0] data_in;
   input  select;
   output data_out;
   
   wire   invL, invR;

   t_nmos nmos_left  (invL, data_in[0], select);
   t_nmos nmos_right (invR, data_in[1], select);

   //   supply1 vcc;
   //   supply0 gdd;

   gate_not inv_left  (invL, invR);
   //   t_pmos pmos0(invL, vcc, invR);
   //   t_nmos nmos0(invL, gdd, invR);

   gate_not inv_right (invR, invL);   
   //   t_pmos pmos1(invR, vcc, invL);
   //   t_nmos nmos1(invR, gdd, invL);

   assign data_out = invL;
endmodule
