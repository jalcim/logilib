/***********************************************************************/
/*                                                                     */
/*   this file is temporary awaiting a scalable implementation         */
/*                                                                     */
/***********************************************************************/

`include "src/primitive/complex_gate/complex_gate.v"

module test_complex_gate;
   reg e1, e2, e3;
   wire	     out_aoi, out_ao;

   gate_aoi aoi_inst(out_aoi, {e3, e2, e1});
   gate_ao  ao_inst (out_ao , {e3, e2, e1});

   initial
     begin
	$dumpfile("signal_test_serial_gate.vcd");
        $dumpvars;
        $monitor("time %d\ne1\t%b\ne2\t%b\ne3\t%b\naoi\t%b\nao\t%b\n\n",
		 $time, e1, e2, e3,
		 out_aoi, out_ao);

	e1 <= 0;
	e2 <= 0;
	e3 <= 0;
	#10;
	e1 <= 1;
	#10;
	e1 <= 0;
	e2 <= 1;
	#10;
	e1 <= 1;
	#10;

	e1 <= 0;
	e2 <= 0;
	e3 <= 1;
	#10;
	e1 <= 1;
	#10;
	e1 <= 0;
	e2 <= 1;
	#10;
	e1 <= 1;
	#10;
     end

endmodule
