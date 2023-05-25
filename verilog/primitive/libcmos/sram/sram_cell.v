module sram_cell(data_out, data_in, sw);
   input  data_in;
   input  select;
   output data_out;
   
   wire   invL, invR;

   gate_not inv_left  (invL, invR);
   gate_not inv_right (invR, invL);   

   t_nmos nmos_left  (invL, data_in, select);
   t_nmos nmos_right (invR, data_in, select);   

   assign data_out = invL;
endmodule
