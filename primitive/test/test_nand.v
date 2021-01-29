module test_nand;
   reg a, b;
   wire s;

   gate_nand nand0(a, b, s);

   integer outfile_test;
   initial
     begin
	outfile_test = $fopen ("build/primitive/log/outfile_test_nand");
	$dumpfile("build/primitive/signal/signal_test_nand.vcd");
	$dumpvars;
	$display("nand");
	$display("\t\ttime,\ta,\tb, \ts");
	$monitor("%d\t%b\t%b\t%b", $time, a, b, s);

	a = 0;
	b = 0;
	#5;
	if (s)
	  begin
	     $fdisplay(outfile_test, "ok");
	  end
	else
	  begin
	     $fdisplay(outfile_test, "fail");
	  end
	#5;

	a = 1;
	b = 0;
	#5;
	if (s)
	  begin
	     $fdisplay(outfile_test, "ok");
	  end
	else
	  begin
	     $fdisplay(outfile_test, "fail");
	  end
	#5;

	a = 0;
	b = 1;
	#5;
	if (s)
	  begin
	     $fdisplay(outfile_test, "ok");
	  end
	else
	  begin
	     $fdisplay(outfile_test, "fail");
	  end
	#5;

	a = 1;
	b = 1;
	#5;
	if (!s)
	  begin
	     $fdisplay(outfile_test, "ok");
	  end
	else
	  begin
	     $fdisplay(outfile_test, "fail");
	  end
	#5;

     end
endmodule // test_nand
