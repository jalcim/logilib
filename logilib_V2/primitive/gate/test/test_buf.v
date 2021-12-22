module test_buf;
   reg a;
   wire s;

   gate_buf buf0 (a, s);

   integer outfile_test;
   initial
     begin
	outfile_test = $fopen ("build/primitive/log/outfile_test_buf");
	$dumpfile("build/primitive/signal/signal_test_buf.vcd");
	$dumpvars;
	$display("buf");
	$display("\t\ttime,\ta,\ts");
	$monitor("%d\t%b\t%b", $time, a, s);
	
	a = 0;
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

	a = 1;
	#5
	if (s)
	  begin
	     $fdisplay(outfile_test, "ok");
	  end
	else
	  begin
	     $fdisplay(outfile_test, "fail");
	  end
	#5;

   end
endmodule // test_buf

