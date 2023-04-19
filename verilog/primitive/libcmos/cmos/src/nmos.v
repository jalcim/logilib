(* blackbox *)
module t_nmos(drain, source, gate);
   input source, gate;
   output drain;
   
   nmos inst(drain, source, gate);
endmodule
