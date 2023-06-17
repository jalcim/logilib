module sram_ctrl(write, data, addr);
   input write, data_in, addr;
   wire  [1:0] data_in;
   wire        data_inv;

   t_nmos data_top   (data_in[0], data, write);
   gate_not inv_data (data_inv, data);
   t_nmos data_down  (data_in[1], data_inv, write);

   sram_cell cell1 (data_out, data_in, 1);
endmodule
