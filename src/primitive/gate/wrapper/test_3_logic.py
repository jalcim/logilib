#!/usr/bin/env python3

from os import environ

import amaranth as am
from amaranth import Signal, Module, Instance
from amaranth.back import rtlil
from amaranth.hdl import ir
from amaranth.hdl.ir import Fragment
from amaranth.back.rtlil import convert_fragment

from collections import defaultdict, OrderedDict

class Verilog_module(am.Elaboratable):
    def __init__(self, name, **kwargs):
        self.kwargs = kwargs


        # module_name, param, pin_in, pin_out, pin_in_out):
        self.name = name

        self.params = []
        for key in kwargs.keys():
            if key[0:2] in ["p_"]:
                print("PARAM:", key)
                self.params.append(kwargs.get(key))

        self.ports = []
        for key in kwargs.keys():
            if key[0:2] in ["i_", "o_"] or key[0:3] in ["io_"]:
                print("PORT:", key)
                self.ports.append(kwargs.get(key))

        self.rtlil_source = "" # TODO
        self.rtlil_file = self.name + ".rtlil"

    def elaborate(self, platform):
        m = Module()
        m.submodules.verilog_counter = Instance(
            self.name,
            **self.kwargs
        )
        return m


class Regroupement():

    def __init__(self):

        # self.param = [2, 2, 2, 2, 2, 2, None, None]
        pin_out = Signal(8)
        pin_in = [Signal(8), Signal(6)]
        # pin_in_out = [Signal(8), Signal(6)]

        """
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
        """

        nom_variable = "WIDTH"
        self.modules = [

            Verilog_module(
                "gate_and",
                **{
                    "p_" + nom_variable : 8,#"p_WIDTH": self.width,
                    "i_clk": Signal(1),
                    "o_cnt" : Signal(8)
                }
            ),
            Verilog_module(
                "gate_nand",
                **{
                    "p_SIZE": 8,
                    "i_clk": Signal(1),
                    "o_cnt" : Signal(8)
                }
            ),
            Verilog_module(
                "gate_or",
                **{
                    "p_WIDTH": 8,
                    "i_clk": Signal(1),
                    "o_cnt" : Signal(8),
                }
            ),
            Verilog_module(
                "gate_nor",
                **{
                    "p_POUET": 8,
                    "i_clk": Signal(1),
                    "io_in_out" : Signal(8)
                }
            )
        ]

def write_rtlil_file(modules_list : Regroupement):
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
            print(f"'{module.rtlil_file}' filename written.")


if __name__ == "__main__":
    modules_list = Regroupement()
    write_rtlil_file(modules_list)
