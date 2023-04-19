module gate_and (e1, e2, s);
   input e1;
   input e2;
   /* verilator lint_off UNOPTFLAT */
   output s;

   and and0(s, e1, e2);
endmodule // and
