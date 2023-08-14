#!/usr/bin/env python3

from os import environ

import amaranth as am
from amaranth.back import rtlil
from amaranth.hdl import ir
from amaranth.hdl.ir import Fragment
from amaranth.back.rtlil import convert_fragment

from src.gate_and import Gate_and

def write_rtlil_file(module : am.Elaboratable):
    platform = None
    emit_src = True
    strip_internal_attrs = False
    fragment = Fragment.get(machin, platform).prepare(ports=module.ports)
    rtlil_text, name_map = convert_fragment(
        fragment,
        module.name,
        emit_src=emit_src,
    )
    ENV_USERNAME = environ.get("USER")
    module.rtlil_source = rtlil_text.replace(ENV_USERNAME, "user")

    with open(module.rtlil_file, "w") as fd:
        fd.write(module.rtlil_source)
        print(f"'{outfile_rtlil}' filename written.")

if __name__ == "__main__":
    in1 = am.Signal(1)
    in2 = am.Signal(1)
    out = am.Signal(1)

    gate_and  = Gate_and (out, in1, in2)
#    gate_nand = Gate_nand(out, in1, in2)
#    gate_or   = Gate_or  (out, in1, in2)
#    gate_nor  = Gate_nor (out, in1, in2)
#    gate_xor  = Gate_xor (out, in1, in2)
#    gate_xnor = Gate_xnor(out, in1, in2)
#    gate_not  = Gate_not (out, in1)
#    gate_buf  = Gate_buf (out, in1)

    write_rtlil_file(gate_and)
