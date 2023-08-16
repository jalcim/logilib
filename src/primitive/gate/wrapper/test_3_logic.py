#!/usr/bin/env python3

from os import environ

import amaranth as am
from amaranth.back import rtlil
from amaranth.hdl import ir
from amaranth.hdl.ir import Fragment
from amaranth.back.rtlil import convert_fragment

class Verilog_modules(am.Elaboratable):
    def __init__(self, module_name, param_list, pin_in, pin_out, pin_in_out):
        self.module_name = module_name

        self.param = param_list

        self.pin_in = pin_in
        self.pin_out = pin_out
        self.pin_in_out = pin_in_out
        self.ports = [self.pin_in, self.pin_out, self.pin_in_out]

        self.rtlil_source
        self.rtlil_file = module_name + ".rtlil"

    def elaborate(self, platform):
        m = Module()
        m.submodules.verilog_counter = Instance(
            self.module_name,
            p_
            o_out = self.ports_out,
            i_in = self.ports_in,
            io_in_out = self.ports_in_out
        )
        return m

class Modules_list():
    def __init__(self):
        self.out = am.Signal(8)
        self.in1 = am.Signal(8)
        self.in2 = am.Signal(6)

        self.modules = [
            Gate_and (out[0], in1[0], in2[0]),
            Gate_nand(out[1], in1[1], in2[1]),
            Gate_or  (out[2], in1[2], in2[2]),
            Gate_nor (out[3], in1[3], in2[3]),
            Gate_xor (out[4], in1[4], in2[4]),
            Gate_xnor(out[5], in1[5], in2[5]),
            Gate_not (out[6], in1[6]),
            Gate_buf (out[7], in1[7])
        ]

def write_rtlil_file(modules_list : Modules_list)
    platform = None
    emit_src = True
    strip_internal_attrs = False

    for module in modules_list.modules:
        fragment = Fragment.get(module, platform).prepare(ports=module.ports)
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
    modules = Modules_list()
    write_rtlil_file(modules)
