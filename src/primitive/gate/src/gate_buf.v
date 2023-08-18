module gate_buf(out, in);
   input in;
   output out;

   buf buf_inst(out, in);
endmodule
