module alu(clk, op, data_in1, data_in2, data_out);
   parameter S = 4;
   parameter T1 = 8;
   parameter T2 = 1;

   input        clk;
   input [3:0]  op;
   input [7:0]  data_in1, data_in2;

   output [7:0] data_out;

   wire [(2**S) * T1 -1: 0] out;

   wire [(2**S) * T1 -1:0] data_in1_wire, data_in2_wire;
   wire [(2**S) -1:0] activate_wire;
   wire [(2**S) -1:0] reset_wire;
   wire [T1-1:0] 	      data_in1_add, data_in2_add, data_in_regdec, data_in_divmod2;

   wire [7:0] 		      ignore;  
   wire 		      power, masse;
   assign power = 1;
   assign masse = 0;

// demultiplexeur sur "data_in1" selon entrer de control "op";
   recurse_demux #(.S(S), .T(T1))demux8_0(op, data_in1, data_in1_wire);
// demultiplexeur sur "data_in2" selon entrer de control "op";
   recurse_demux #(.S(S), .T(T1))demux8_1(op, data_in2, data_in2_wire);
// demultiplexeur activateur selon entrer de control "op";
   recurse_demux #(.S(S), .T(T2))demux8_2(op, power   , activate_wire);
////////////////////////////////////////////////////////////////////////////////////////////////////////
   gate_not8 not0(activate_wire[7:0] , reset_wire[7 :0]);
   gate_not8 not1(activate_wire[15:8], reset_wire[15:8]);

   gate_or8 or0(  data_in1_wire[7:0],
		  data_in1_wire[15:8],
		  data_in1_add);
   gate_or8 or1(  data_in2_wire[7:0],
		  data_in2_wire[15:8],
		  data_in2_add);
   gate_or8 or2(  data_in1_wire[23:16],
		  data_in1_wire[31:24],
		  data_in_divmod2);
   gate_or8 or3(  data_in2_wire[119:112],
		  data_in2_wire[127:120],
		  data_in_regdec);
////////////////////////////////////////////////////////////////////////////////////////////////////////
/*0  */   add8     add8(data_in1_add, data_in2_add, z, activate_wire[1], out[7:0], z);
/*1  */   gate_buf8 buf0(out[7:0], out[15:8]);

//la division et modulo feront desormais partie d'une autre unite specialiser
/*2&3*///   divmod2 divmod2(activate_wire[], clk, reset_wire[2],data_in_divmod2, out[23:16], out[31:24], z);
//la multiplication fera desormais partie d'une autre unite specialiser
/*4  *///   mult_8   mult8(activate_wire[4], clk, reset_wire[4], data_in1_wire[39:32], data_in2_wire[39:32], out[39:32], ignore);
/*5  */   cmp8    cmp8(data_in1_wire[47:40], data_in2_wire[47:40], out[42], out[41], out[40]);//modification pour sortie sur bus 8bit
          gate_buf buf_cmp3(masse, out[43]);gate_buf buf_cmp4(masse, out[44]);
          gate_buf buf_cmp5(masse, out[45]);gate_buf buf_cmp6(masse, out[46]);
          gate_buf buf_cmp7(masse, out[47]);

//*6  */   gate_buf8    buf8 (data_in1_wire[55 :48 ],                         out[55 :48 ]);
/*7  */   gate_not8    not8 (data_in1_wire[63 :56 ],                         out[63 :56 ]);
/*8  */   gate_and8    and8 (data_in1_wire[71 :64 ], data_in2_wire[71 :64 ], out[71 :64 ]);
//   gate_buf8 debug0(data_in2, out[71:64]);
   
//*9  */   gate_nand8   nand8(data_in1_wire[79 :72 ], data_in2_wire[79 :72 ], out[79 :72 ]);
/*10 */   gate_or8     or8  (data_in1_wire[87 :80 ], data_in2_wire[87 :80 ], out[87 :80 ]);
//*11 */   gate_nor8    nor8 (data_in1_wire[95 :88 ], data_in2_wire[95 :88 ], out[95 :88 ]);
//*12 */   gate_xor8    xor8 (data_in1_wire[103:96 ], data_in2_wire[103:96 ], out[103:96 ]);
//*13 */   gate_xnor8   xnor8(data_in1_wire[111:104], data_in2_wire[111:104], out[111:104]);

/*14*/   regdec  regdec(data_in_regdec, activate_wire[14], out[119:112]);
/*15*/   gate_buf8 buf1(out[119:112], out[127:120]);
////////////////////////////////////////////////////////////////////////////////////////////////////////
   //multiplexeur sur les sorties selon entrer de control "op"
   recurse_mux #(.S(S), .T(T1)) mux_out(op, out, data_out);
endmodule // alu
