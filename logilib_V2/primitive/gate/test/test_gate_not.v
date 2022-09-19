module test_gate_not;
   wire out;
   reg	in;

   integer i;
   gate_not gate_not0(out, in);

   initial
     begin
	$dumpfile("signal_gate_not.vcd");
        $dumpvars;
        $display("\t\ttime, \tin, \tout");
        $monitor("%d \t%b\t%b", $time, in, out);

	in <= 0;
	i <= 0;
     end

   always
     begin
	#20;
	in <= ~in;
	i++;
	if (i > 5)
	  $finish;
     end
endmodule
