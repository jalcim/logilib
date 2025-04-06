/***********************************************************************/
/*                                                                     */
/*   this file is temporary awaiting a scalable implementation         */
/*                                                                     */
/***********************************************************************/


`ifndef __GATE_AOI__
 `define  __GATE_AOI__

 `include "src/primitive/gate/gate_and.v"
 `include "src/primitive/gate/gate_nor.v"

//   !((in[0] & in[1]) | in[2])
module gate_aoi(out, in);
   input [2:0] in;
   output      out;
   wire	       line;

   and and_inst(line, in[0], in[1]);
   nor  nor_inst (out , line , in[2]);
endmodule

`endif

`ifndef __GATE_AO__
 `define  __GATE_AO__

 `include "src/primitive/gate/gate_and.v"
 `include "src/primitive/gate/gate_or.v"

//   (in[0] & in[1]) | in[2]
module gate_ao(out, in);
   input [2:0] in;
   output      out;
   wire	       line;

   and and_inst(line, in[0], in[1]);
   or  or_inst (out , line , in[2]);
endmodule

`endif
