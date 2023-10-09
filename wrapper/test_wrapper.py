#!/usr/bin/env python3

import amaranth as am
from wrapper import Module

if __name__ == "__main__":

    # cells : composants primitifs de bas niveau (abstraction matérielle)
    top_cell1 = Module("gate_and", p_WAY=2, p_WIRE=1)#, reg_in=True, reg_out=False)  # cells
    top_cell1.reg_in = True;
    top_cell1.reg_out = False;
    
    # si ils sont enregistrés, le module herite des ports de ses enfants

    top_cell2 = Module("gate_and", p_WAY=2, p_WIRE=1)#, reg_in=True, reg_out=False)
    top_cell2.reg_in = True;
    top_cell2.reg_out = False;

    # routage
    in_3 = am.Cat(top_cell1.get("o_out"), top_cell2.get("o_out"))
    top_cell3 = Module("gate_and", p_WAY=2, p_WIRE=1, i_in=in_3)#, reg_in=False, reg_out=False)
    top_cell3.reg_in = False;
    top_cell3.reg_out = False;

    in_4 = top_cell3.get("o_out")
    top_cell4 = Module("gate_not", p_WIRE=1, i_in=in_4)#, reg_in=False, reg_out=True)
    top_cell4.reg_in = False;
    top_cell4.reg_out = True;

    # enregistrement des cells/submodules dans le Module pere 
    top = Module("top")
    top.add_submodules([top_cell1, top_cell2, top_cell3, top_cell4])

    # elaboration et ecriture du rtlil
    top.write_rtlil_file()
