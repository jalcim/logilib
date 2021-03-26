module memory(write, read, clk, reset, activate, addrin,
	     addrout, datain, dataout, error);
   parameter DEMUX_WAY = 4;
   parameter DEMUX_WIRE = 1;

   parameter MUX_WAY = 4;
   parameter MUX_WIRE = 8;

   parameter MINIMUX_WAY = 1;
   parameter MINIMUX_WIRE = 8;

   parameter DLATCH_ADDR = 2;

   parameter DLATCH_MEM = 7;

   parameter DLATCH_DATA = 3;

   parameter WIRE_DATAIN = 3;
   parameter WAY_DATAIN = 4;

   parameter WIRE_ACTIVE_DLATCH = 0;
   parameter WAY_ACTIVE_DLATCH = 3;
   parameter BUS_ACTIVE_DLATCH = 4;
   
   input write, read, clk, reset, activate;
   input [3:0] addrin, addrout;
   input [7:0] datain;

   output      error;
   output [7:0] dataout;

   wire [7:0] 	clk_repeater, unclk_repeater;
   wire 	out_and0, out_and1;
   wire [3:0] 	out_Dlatch_addrin, out_Dlatch_addrout;
   wire [7:0] 	out_Dlatch_datain;
   wire [15:0] 	out_demux;
   wire [7:0] 	out_mux;
   wire [2**DLATCH_MEM - 1:0] data_in_Dlatch, active_Dlatch, data_out_Dlatch, invert_data_out_Dlatch;//16x8-1:0

   wire [7:0] 		      verif_read, read_bus;
   wire [3:0] 		      ignore_4, ignore_4_1;
   wire [7:0] 		      ignore_8, ignore_8_1;

   wire 	error_line, error_line0, error_line1, error_read;
   wire [7:0] null_line;

   assign null_line = 0;
   assign error_line = 0;
   assign error = 0;
   
   gate_not not_clk0(clk, unclk_repeater[0]);
   gate_not not_clk1(clk, unclk_repeater[1]);
   gate_not not_clk2(clk, unclk_repeater[2]);
   gate_not not_clk3(clk, unclk_repeater[3]);
   gate_not not_clk4(clk, unclk_repeater[4]);
   gate_not not_clk5(clk, unclk_repeater[5]);
   gate_not not_clk6(clk, unclk_repeater[6]);
   gate_not not_clk7(clk, unclk_repeater[7]);

   gate_buf buf_clk0(clk, clk_repeater[0]);
   gate_buf buf_clk1(clk, clk_repeater[1]);
   gate_buf buf_clk2(clk, clk_repeater[2]);
   gate_buf buf_clk3(clk, clk_repeater[3]);
   gate_buf buf_clk4(clk, clk_repeater[4]);
   gate_buf buf_clk5(clk, clk_repeater[5]);
   gate_buf buf_clk6(clk, clk_repeater[6]);
   gate_buf buf_clk7(clk, clk_repeater[7]);
   
   gate_and and0(write, activate, out_and0);
   gate_and and1(out_and0, clk, out_and1);

   recursive_Dlatch #(.S(DLATCH_ADDR)) Dlatch_addrin(addrin[3:0], unclk_repeater[3:0], reset, out_Dlatch_addrin[3:0], ignore_4);
   recursive_Dlatch #(.S(DLATCH_DATA)) Dlatch_datain(datain[7:0], unclk_repeater[7:0], reset, out_Dlatch_datain[7:0], ignore_8);



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   recurse_demux #(.S(DEMUX_WAY),
		   .T(DEMUX_WIRE)) demux(out_Dlatch_addrin[3:0], out_and1, out_demux[15:0]);

   replicator #(.WIRE(WIRE_DATAIN), //replique de datain sur 16WAY 1WIRE
		.WAY(WAY_DATAIN))replicator_datain(datain[7:0], data_in_Dlatch[127:0]);

   fragmented_replicator #(.WIRE(WIRE_ACTIVE_DLATCH),//replique de l'activation des bascule 16bus 8way 1wire
			   .WAY(WAY_ACTIVE_DLATCH),
			   .BUS(BUS_ACTIVE_DLATCH)) fragmented_replicator(out_demux[15:0],
									  active_Dlatch[127:0]);

   recursive_Dlatch #(.S(DLATCH_MEM)) Dlatch_mem(data_in_Dlatch[127:0], active_Dlatch[127:0], reset, data_out_Dlatch[127:0], invert_data_out_Dlatch[127:0]);
///////////////////////////////////////////////////////////////// 

   recursive_Dlatch #(.S(DLATCH_ADDR)) Dlatch_addrout(addrout[3:0], unclk_repeater[3:0], reset, out_Dlatch_addrout[3:0], ignore_4_1);
  
   recurse_mux #(.S(MUX_WAY), .T(MUX_WIRE)) mux(out_Dlatch_addrout[3:0], data_out_Dlatch[127:0], out_mux[7:0]);

   gate_not not_error_read(error_line, error_line0);
   gate_and and_error_read0(read, error_line0, error_line1);
   gate_and and_error_read1(activate, error_line1 , error_read);

   recurse_mux #(.S(MINIMUX_WAY), .T(MINIMUX_WIRE)) minimux0(error_read, {out_mux[7:0], null_line[7:0]}, verif_read[7:0]);
   recurse_mux #(.S(MINIMUX_WAY), .T(MINIMUX_WIRE)) minimux1(clk, {verif_read[7:0], null_line[7:0]}, read_bus[7:0]);
   recursive_Dlatch #(.S(DLATCH_DATA)) Dlatch_dataout(read_bus[7:0], clk_repeater[7:0], reset, dataout[7:0], ignore_8_1);

endmodule
