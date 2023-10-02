module sequential_regdec_right(input [2:0] 	  sequenceur,
			 input [2**WIRE-1:0]  bus_in,
			 input 		      propagator,
			 input 		      clk,
			 input 		      reset,
			 output [2**WIRE-1:0] bus_out);

   parameter WIRE 			      = 3;

   wire [2**(WIRE-1)-1:0] 		      out_regdec0;
   wire 				      out1;

   if (WIRE == 1)
     begin
	block_regdec block_regdec0(sequenceur, bus_in[1], propagator, clk, reset, out1);
	gate_buf gate_buf(out1, bus_out[1]);
	block_regdec block_regdec1(sequenceur, bus_in[0], out1, clk, reset,  bus_out[0]);
     end
   else
     begin
	sequential_regdec_right #(.WIRE(WIRE-1))regdec0(sequenceur, bus_in[2**WIRE-1:2**(WIRE-1)],
						  propagator, clk, reset, out_regdec0);
	
	assign bus_out[2**WIRE-1:2**(WIRE-1)] = out_regdec0;
	
	sequential_regdec_right #(.WIRE(WIRE-1))regdec1(sequenceur, bus_in[2**(WIRE-1)-1:0],
				  out_regdec0[0], clk, reset, bus_out[2**(WIRE-1)-1:0]);

     end
   
endmodule // sequential_regdec

module sequential_regdec_left(input [2:0] 	  sequenceur,
			 input [2**WIRE-1:0]  bus_in,
			 input 		      propagator,
			 input 		      clk,
			 input 		      reset,
			 output [2**WIRE-1:0] bus_out);

   parameter WIRE 			      = 3;

   wire [2**(WIRE-1)-1:0] 		      out_regdec0;
   wire 				      out0;

   if (WIRE == 1)
     begin
	block_regdec block_regdec0(sequenceur, bus_in[0], propagator, clk, reset, out0);
	gate_buf gate_buf(out0, bus_out[0]);
	block_regdec block_regdec1(sequenceur, bus_in[1], out0, clk, reset,  bus_out[1]);
     end
   else
     begin
	sequential_regdec_left #(.WIRE(WIRE-1))regdec0(sequenceur, bus_in[2**(WIRE-1)-1:0],
						  propagator, clk, reset, out_regdec0);
	
	assign bus_out[2**(WIRE-1)-1:0] = out_regdec0;
	
	sequential_regdec_left #(.WIRE(WIRE-1))regdec1(sequenceur, bus_in[2**WIRE-1:2**(WIRE-1)],
				  out_regdec0[0], clk, reset, bus_out[2**WIRE-1:2**(WIRE-1)]);

     end
   
endmodule // sequential_regdec

module block_regdec(input [2:0] sequenceur,
		    input  in,
		    input  propagator,
		    input  clk,
		    input  reset,
		    output out);
   parameter S = 2;
   parameter T = 1;

   wire 		   out_mux;
   wire 		   latch_mux_line;
   wire 		   ignore;
   supply0 		   masse;
   
   recurse_mux #(.S(S), .T(T))mux(sequenceur[1:0],
				   {masse,propagator,in,latch_mux_line},
				   out_mux);
   Dflip_flop flipflopD(out_mux, clk, reset, latch_mux_line, ignore);
   gate_buf gate_buf(latch_mux_line, out);
endmodule // block_regdec
