module test_basculeD;
   reg a, clk, reset;
   wire s1, s2;

   basculeD basculeD(a, clk, reset, s1, s2);

   integer output_file;
   reg 	   state;
   initial
     begin
	output_file = $fopen("build/memory/log/outfile_test_basculeD");
	$dumpfile("build/memory/signal/signal_test_basculeD.vcd");
	$dumpvars;
	$display("basculeD");
	$display("\t\ttime,\ta,\tclk,\treset,\ts1,\ts2,\tstate");
	$monitor("%d\t%b\t%b\t%b\t%b\t%b\t%b", $time, a, clk, reset, s1, s2, state);

	state = 0;
	#5;
	a = 0;
	clk = 0;
	reset = 1;
	if (~state & (a & clk))
	  begin
	     state = 1;
	  end
	else if (state & (~a & clk))
	  begin
	     state = 0;
	  end
	#5;
	if (!s1 && s2)
	  begin
	     $fdisplay(output_file, "ok");
	  end
	else
	  begin
	     $fdisplay(output_file, "fail");
	  end
	#5;
	a = 0;
	clk = 0;
	reset = 0;
	if (~state & (a & clk))
	  begin
	     state = 1;
	  end
	else if (state & (~a & clk))
	  begin
	     state = 0;
	  end
	#5;
	if (!s1 && s2)
	  begin
	     $fdisplay(output_file, "ok");
	  end
	else
	  begin
	     $fdisplay(output_file, "fail");
	  end
	#5;
	a = 1;
	clk = 0;
	reset = 0;
	if (~state & (a & clk))
	  begin
	     state = 1;
	  end
	else if (state & (~a & clk))
	  begin
	     state = 0;
	  end
	#5;
	if (!s1 && s2)
	  begin
	     $fdisplay(output_file, "ok");
	  end
	else
	  begin
	     $fdisplay(output_file, "fail");
	  end
	#5;
	a = 0;
	clk = 1;
	reset = 0;
	if (~state & (a & clk))
	  begin
	     state = 1;
	  end
	else if (state & (~a & clk))
	  begin
	     state = 0;
	  end
	#5;
	if (!s1 && s2)
	  begin
	     $fdisplay(output_file, "ok");
	  end
	else
	  begin
	     $fdisplay(output_file, "fail");
	  end
	#5;
	a = 1;
	clk = 1;
	reset = 0;
	if (~state & (a & clk))
	  begin
	     state = 1;
	  end
	else if (state & (~a & clk))
	  begin
	     state = 0;
	  end
	#5;
	if (s1 && !s2)
	  begin
	     $fdisplay(output_file, "ok");
	  end
	else
	  begin
	     $fdisplay(output_file, "fail");
	  end
	#5;
	a = 0;
	clk = 0;
	reset = 0;
	if (~state & (a & clk))
	  begin
	     state = 1;
	  end
	else if (state & (~a & clk))
	  begin
	     state = 0;
	  end
	#5;
	if (s1 && !s2)
	  begin
	     $fdisplay(output_file, "ok");
	  end
	else
	  begin
	     $fdisplay(output_file, "fail");
	  end
	#5;
	a = 1;
	clk = 0;
	reset = 0;
	if (~state & (a & clk))
	  begin
	     state = 1;
	  end
	else if (state & (~a & clk))
	  begin
	     state = 0;
	  end
	#5;
	if (s1 && !s2)
	  begin
	     $fdisplay(output_file, "ok");
	  end
	else
	  begin
	     $fdisplay(output_file, "fail");
	  end
	#5;
	a = 0;
	clk = 1;
	reset = 0;
	if (~state & (a & clk))
	  begin
	     state = 1;
	  end
	else if (state & (~a & clk))
	  begin
	     state = 0;
	  end
	#5;
	if (!s1 && s2)
	  begin
	     $fdisplay(output_file, "ok");
	  end
	else
	  begin
	     $fdisplay(output_file, "fail");
	  end
	#5;
	a = 0;
	clk = 0;
	reset = 0;
	if (~state & (a & clk))
	  begin
	     state = 1;
	  end
	else if (state & (~a & clk))
	  begin
	     state = 0;
	  end
	#5;
	if (!s1 && s2)
	  begin
	     $fdisplay(output_file, "ok");
	  end
	else
	  begin
	     $fdisplay(output_file, "fail");
	  end
	#5;
	a = 0;
	clk = 0;
	reset = 1;
	if (~state & (a & clk))
	  begin
	     state = 1;
	  end
	else if (state & (~a & clk))
	  begin
	     state = 0;
	  end
	#5;
	if (!s1 && s2)
	  begin
	     $fdisplay(output_file, "ok");
	  end
	else
	  begin
	     $fdisplay(output_file, "fail");
	  end
	#5;
     end
endmodule // test_basculeD
