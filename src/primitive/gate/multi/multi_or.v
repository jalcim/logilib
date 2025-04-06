`ifndef __MULTI_OR__
 `define __MULTI_OR__
 `include "src/primitive/gate/gate_or.v"

module multi_or(addr, converged);
   parameter NB_GATE = 4;
   parameter WAY = 8;
   parameter WIRE = 1;
   
   input [(NB_GATE*WAY)-1:0] converged;
   output [NB_GATE-1:0] addr;

   gate_or #(.WAY(WAY), .WIRE(WIRE))
   inst_or(addr[NB_GATE-1], converged[NB_GATE*WAY-1:(NB_GATE-1)*WAY]);
   if (NB_GATE > 1)
     begin
	multi_or #(.NB_GATE(NB_GATE-1))
	inst_mult_or(addr[NB_GATE-2:0],
		     converged[((NB_GATE-1)*WAY)-1:0]);
     end
endmodule

`endif
