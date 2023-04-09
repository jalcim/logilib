(* blackbox *)
module t_pmos(drain, source, gate);
   input source, gate;
   output drain;

   pmos t_inst(drain, source, gate);
endmodule
