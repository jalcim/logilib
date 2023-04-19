module test_datapath;
   reg clk, charge, reset, Bctrl, read, write, activate;
   reg [1:0] addr_reg, outA, outB, reg_data_ctrl, datain_ctrl, addrin_ctrl, addrout_ctrl;
   reg [3:0] op;
   reg [7:0] datain, reg_datain, addrin, addrout;

   output [7:0] out_regA, out_regB, out_alu, out_mem;
   
   
   datapath t_datapath(clk, charge, reset, addr_reg, outA, outB, datain, op,
	    reg_data_ctrl, reg_datain, Bctrl, datain_ctrl, addrin,
	    addrin_ctrl,addrout, addrout_ctrl, read, write, activate,
	    out_regA, out_regB, out_alu, out_mem, error);

   initial
     begin
	$dumpfile("build/datapath/signal/signal_datapath.vcd");
	$dumpvars;
//	$display("\n\ntime, \nclk, \ncharge, \nreset, \nBctrl, \nread, \nwrite, \nactivate, \n, \ndataout, \nerror");
	$monitor("time=%d\n clk=%d\n charge=%b\n reset=%b\n Bctrl=%b\n read=%b\n write=%b\n activate=%b\n\naddr_reg=%d\n outA=%d\n outB=%d\n reg_data_ctrl=%d\n datain_ctrl=%d\n addrin_ctrl=%d\n\naddrout_ctrl=%d\n op=%d\n datain=%d\n reg_datain=%d\n addrin=%d\n addrout=%d\n\nout_regA=%d\n out_regB=%d\n out_alu=%d\n out_mem=%d\n\n\n\n\n", $time, clk, charge, reset, Bctrl, read, write, activate, addr_reg, outA, outB, reg_data_ctrl, datain_ctrl, addrin_ctrl, addrout_ctrl, op, datain, reg_datain, addrin, addrout, out_regA, out_regB, out_alu, out_mem);


	//init
	clk = 0;
	charge = 0;
	Bctrl = 0;
	read = 0;
	write = 0;
	activate = 0;
	addr_reg = 0;
	outA = 0;
	outB = 0;
	reg_data_ctrl = 0;
	datain_ctrl = 0;
	addrin_ctrl = 0;
	addrout_ctrl = 0;
	op = 0;
	datain = 0;
	reg_datain = 0;
	addrin = 0;
	addrout = 0;
	reset = 1;
	#100;
	//ecriture dans blockreg
	reset = 0;
	charge = 1;
	reg_datain = 7;
	reg_data_ctrl = 2;
	addr_reg = 1;
	#100;
	clk = 1;
	#100;
	clk = 0;
	//lecture dans blockreg -> alu -> ecriture dans memory
	charge = 0;
	reg_datain = 0;
	reg_data_ctrl = 0;
	addr_reg = 0;
////////////////////
	outA = 1;

	op = 1;//buff

	datain_ctrl = 1;
	write = 1;
	activate = 1;

	addrin = 4;
	addrin_ctrl = 2;
	addrout = 0;
	addrout_ctrl = 2;
	#100;
	clk = 1;
	#100;
	//lecture de memory
	clk = 0;
	#100;
	datain_ctrl = 0;
	write = 0;
	activate = 1;
	read = 1;

	addrin = 0;
	addrin_ctrl = 0;
	addrout = 4;
	addrout_ctrl = 2;
	#100;
	clk = 1;
	#100;
	clk = 0;
     end   
endmodule // test_datapath
