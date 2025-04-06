module test_sram_cell;
   reg data;
   reg select;

   wire [1:0] data_in;
   wire data_out;

   assign data_in[0] = data;
   gate_not inv_data(data_in[1], data);
   sram_cell cell1 (data_out, data_in, select);

   initial
     begin
	$dumpfile("signal_test_sram_cell.vcd");
        $dumpvars;
        $display("\t\ttime, \tdata_out, \tdata, \tselect");
        $monitor("%d \t%b\t\t%b\t%b", $time, data_out, data, select);

	data <= 0;
	select <= 0;
	#10;
	data <= 0;
	select <= 1;
	#10;
	select <= 0;
	data <= 1;
	#10;
	select <= 1;
	#10;
     end

endmodule
