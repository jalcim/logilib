module sram_cell(data_out, data_in, sw);
   input  [1:0] data_in;
   input  select;
   output data_out;
   
   wire   invL, invR;

   gate_not inv_left  (invL, invR);
   gate_not inv_right (invR, invL);   

   t_nmos nmos_left  (invL, data_in[0], select);
   t_nmos nmos_right (invR, data_in[1], select);   

   assign data_out = invL;
endmodule
