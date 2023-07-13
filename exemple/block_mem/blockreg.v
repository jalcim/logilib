module blockreg(clk, reset, charge, addr_reg, outA,
		outB, datain, dataoutA, dataoutB, error);

   parameter WAY_DEMUX = 2;
   parameter WIRE_DEMUX = 1;
   
   parameter WAY_MUX = 2;
   parameter WIRE_MUX = 8;
   parameter WAY_MINIMUX = 1;

   parameter WIRE_REPLICATOR = 3;
   parameter WAY_REPLICATOR = 2;

   parameter WIRE_ACTIVE_DLATCH = 0;
   parameter WAY_ACTIVE_DLATCH = 3;
   parameter BUS_ACTIVE_DLATCH = 2;

   parameter WIRE_REPLICATOR_SYNC = 0;
   parameter WAY_REPLICATOR_SYNC = 4;

   parameter DLATCH_SYNC = 4;
   parameter DLATCH_REG = 5;
   parameter BUF_OUT = 3;

   input clk, reset, charge;
   input [1:0] addr_reg, outA, outB;
   input [7:0] datain;
   output [7:0] dataoutA, dataoutB;
   output 	error;

   wire 	and_out;
   wire [3:0] 	out_demux;
   wire [7:0] 	ignore8_0, ignore8_1;
   wire [31:0] 	mux0_out, mux1_out, data_in_Dlatch_reg, Dlatch_reg_out, clk_line, active_Dlatch_reg;
   wire [15:0] 	minimux_out, Dlatch_sync_out;
   wire [7:0] 	null_line;
   wire [31:0] 	ignore32;
   wire [15:0] 	ignore16;

   assign error = 0;
   assign null_line = 0;

   gate_and and0(clk, charge, and_out);
   recurse_demux #(.S(WAY_DEMUX), .T(WIRE_DEMUX)) demux0(addr_reg[1:0], and_out, out_demux[3:0]);

   replicator #(.WIRE(WIRE_REPLICATOR), .WAY(WAY_REPLICATOR)) replicator_datain(datain[7:0], data_in_Dlatch_reg[31:0]);
//   replicator #(.WIRE(WIRE_REPLICATOR_ACTIVE), .WAY(WAY_REPLICATOR_ACTIVE)) replicator_active_in(out_demux[3:0], active_Dlatch_reg[31:0]);   

   fragmented_replicator #(.WIRE(WIRE_ACTIVE_DLATCH),
			   .WAY(WAY_ACTIVE_DLATCH),
			   .BUS(BUS_ACTIVE_DLATCH)) fragmented_replicator(out_demux[3:0], active_Dlatch_reg[31:0]);

   recursive_Dlatch #(.S(DLATCH_REG)) Dlatch_reg(data_in_Dlatch_reg[31:0], active_Dlatch_reg[31:0], reset, Dlatch_reg_out[31:0], ignore32);

   recurse_mux #(.S(WAY_MUX), .T(WIRE_MUX)) mux0(outA, Dlatch_reg_out[31:0], mux0_out[7:0]);
   recurse_mux #(.S(WAY_MUX), .T(WIRE_MUX)) mux1(outB, Dlatch_reg_out[31:0], mux1_out[7:0]);

   recurse_mux #(.S(WAY_MINIMUX), .T(WIRE_MUX)) minimux0(clk, {mux0_out[7:0], null_line[7:0]}, minimux_out[7:0]);
   recurse_mux #(.S(WAY_MINIMUX), .T(WIRE_MUX)) minimux1(clk, {mux1_out[7:0], null_line[7:0]}, minimux_out[15:8]);

   replicator #(.WIRE(WIRE_REPLICATOR_SYNC), .WAY(WAY_REPLICATOR_SYNC)) replicator_sync(clk, clk_line[15:0]);
   recursive_Dlatch #(.S(DLATCH_SYNC)) Dlatch_sync(minimux_out[15:0], clk_line[15:0], reset, Dlatch_sync_out[15:0], ignore16);
   recursive_buf #(.S(BUF_OUT)) buf_outA(minimux_out[7:0], dataoutA[7:0]);
   recursive_buf #(.S(BUF_OUT)) buf_outB(minimux_out[15:8], dataoutB[7:0]);

endmodule // blockreg
