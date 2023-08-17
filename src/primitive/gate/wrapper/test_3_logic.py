#!/usr/bin/env python3

from os import environ

import amaranth as am
from amaranth.back import rtlil
from amaranth.hdl import ir
from amaranth.hdl.ir import Fragment
from amaranth.back.rtlil import convert_fragment

from collections import defaultdict, OrderedDict

class Verilog_module(am.Elaboratable):
    def __init__(self, module_name, param, pin_in, pin_out, pin_in_out):
        self.module_name = module_name

 #       self.param = param

        self.ports = [self.pin_in, self.pin_out, self.pin_in_out]

        self.rtlil_source
        self.rtlil_file = module_name + ".rtlil"

    def elaborate(self, platform):
        m = Module()
        m.submodules.verilog_counter = Instance(
            self.module_name,
            p_[]
            o_out = self.ports_out,
            i_in = self.ports_in,
            io_in_out = self.ports_in_out
        )
        return m

class Modules_list():
    def __init__(self):
        nom_variable = "WIDTH"
        kwargs = {
            "p_" + nom_variable : 8,#"p_WIDTH": self.width,
            "i_clk": Signal(1),
            "o_cnt" : Signal(8)
    }

#        self.param = [2, 2, 2, 2, 2, 2, None, None]
        self.out = am.Signal(8)
        self.pin_in = [am.Signal(8), am.Signal(6)]
        self.pin_in_out

        self.modules = [
            Verilog_module("gate_and"  , self.param[0], self.out[0], [self.pin_in[0][0], self.pin_in[1][0]], None),
            Verilog_module("gate_nand" , self.param[1], self.out[1], [self.pin_in[0][1], self.pin_in[1][1]], None),
            Verilog_module("gate_or"   , self.param[2], self.out[2], [self.pin_in[0][2], self.pin_in[1][2]], None),
            Verilog_module("gate_nor"  , self.param[3], self.out[3], [self.pin_in[0][3], self.pin_in[1][3]], None),
            Verilog_module("gate_xor"  , self.param[4], self.out[4], [self.pin_in[0][4], self.pin_in[1][4]], None),
            Verilog_module("gate_xnor" , self.param[5], self.out[5], [self.pin_in[0][5], self.pin_in[1][5]], None),
            Verilog_module("gate_not"  , self.param[6], self.out[6], self.pin_in[0][6], None),
            Verilog_module("gate_buf"  , self.param[7], self.out[7], self.pin_in[0][7], None),
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
