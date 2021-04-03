module gate_buf (e1, s);
   input e1;
   output s;

   buf buf0(s, e1);
endmodule // gate_buf
