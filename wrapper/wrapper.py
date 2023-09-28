#!/usr/bin/env python3

from os import environ

import amaranth as am
# from amaranth import Signal, Module, Instance
from amaranth.back import rtlil
from amaranth.hdl import ir
from amaranth.hdl.ir import Fragment
from amaranth.back.rtlil import convert_fragment

from collections import defaultdict, OrderedDict

class Verilog_module(am.Elaboratable):
    def __init__(self, name, id, **kwargs):
        self.kwargs = kwargs
        self.name = name
        self.rtlil_source = "" #affectation dans write_rtlil_file
        self.rtlil_file = self.name + id + ".rtlil"
        self.update_prefab()

    def update_prefab(self):
        self.params = []
        for key in self.kwargs.keys():
            if key[0:2] in ["p_"]:
                print("PARAM:", key)
                self.params.append(self.kwargs.get(key))

        self.ports = []
        for key in self.kwargs.keys():
            if key[0:2] in ["i_", "o_"] or key[0:3] in ["io_"]:
                print("PORT:", key)
                self.ports.append(self.kwargs.get(key))

    def elaborate(self, platform):
        m = am.Module()
        m.submodules.verilog = am.Instance(
            self.name,
            **self.kwargs
        )
        return m

# must be updated with each module_type
ALLOWED_PARAMS = {
    "gate_and": ["WAY", "WIRE"],
    "gate_or": ["WAY", "WIRE"],
    "gate_not": ["WIRE"],
    "gate_nand": ["WAY", "WIRE"],
}

class Module():

    module_id = 0 # auto increment

    def __init__(self, module_type, params, allocate):
        if allocate == 1:
            if module_type == "gate_or":
                self.params = {
                    "i_in" : am.Signal(params["WAY"] * params["WIRE"]),
                    "o_out": am.Signal(params["WIRE"]),
                }
            elif module_type == "gate_and":
                self.params = {
                    "i_in" : am.Signal(params["WAY"] * params["WIRE"]),
                    "o_out": am.Signal(params["WIRE"]),
                }
            elif module_type == "gate_nand":
                self.params = {
                    "i_in" : am.Signal(params["WAY"] * params["WIRE"]),
                    "o_out": am.Signal(params["WIRE"]),
                }
            elif module_type == "gate_not":
                self.params = {
                    "i_in" : am.Signal(params["WIRE"]),
                    "o_out": am.Signal(params["WIRE"]),
                }
        else :
            self.params = {
                "i_in" : 0,
                "o_out": am.Signal(params["WIRE"]),
            }

        self.params.update({"p_" + key: value for key, value in params.items() if key in ALLOWED_PARAMS[module_type]})
        self.module = Verilog_module(
            module_type,
            str(Module.module_id),
            **self.params
        )
        Module.module_id += 1

    def get(self, key):
        return self.module.kwargs.get(key)

    def set(self, key : str, value):
        self.module.kwargs[key] = value
        self.module.update_prefab()


def write_rtlil_file(modules_list : list):
    platform = None
    emit_src = True
    strip_internal_attrs = False

    for elem in modules_list:
        fragment = Fragment.get(elem.module, platform).prepare(ports=elem.module.ports)
        rtlil_text, name_map = convert_fragment(
            fragment,
            "wrapper_" + elem.module.name,
            emit_src=emit_src,
        )
        ENV_USERNAME = environ.get("USER")
        elem.module.rtlil_source = rtlil_text.replace(ENV_USERNAME, "user")

        with open(elem.module.rtlil_file, "w") as fd:
            fd.write(elem.module.rtlil_source)
            print(f"'{elem.module.rtlil_file}' filename written.")


def write_top_rtlil(top : am.Elaboratable):
    name = "top"
    platform = None
    emit_src = True
    strip_internal_attrs = False
    fragment = Fragment.get(top, platform).prepare(ports=top.ports)
    rtlil_text, name_map = convert_fragment(
        fragment,
        name,
        emit_src=emit_src,
    )
    ENV_USERNAME = os.environ.get("USER")
    rtlil_source_text = rtlil_text.replace(ENV_USERNAME, "user")
    return rtlil_source_text

class Top(am.Elaboratable):
    def __init__(self):
        self.gate1 = Module("gate_and", {"WAY": 2, "WIRE": 1}, 1)
        self.gate2 = Module("gate_and", {"WAY": 2, "WIRE": 1}, 1)
        self.gate3 = Module("gate_and", {"WAY": 2, "WIRE": 1}, 0)

    def elaborate(self, platform):
        top = am.Module()
        top.submodules.gate_and1 = self.gate1.module
        top.submodules.gate_and2 = self.gate2.module
        top.submodules.gate_and3 = self.gate3.module

        self.ports = []

        for pin in self.gate1.module.ports :
            self.ports.append(pin)

        for pin in self.gate2.module.ports :
            self.ports.append(self.gate2.module.ports)

        for pin in self.gate3.module.ports :
            self.ports.append(self.gate3.module.ports)

        self.gate3.set("i_in", am.Cat(self.gate1.get("o_out"), self.gate2.get("o_out")))
        return top

if __name__ == "__main__":

    # exemple :
    module_1 = Module("gate_not" , {"WIRE": 1}, 1)
    module_2 = Module("gate_or"  , {"WAY": 2, "WIRE": 1}, 1)
    module_3 = Module("gate_nand", {"WAY": 2, "WIRE": 1}, 1)
    module_4 = Module("gate_and", {"WAY": 2, "WIRE": 1}, 1)

    module_1.set("p_WIRE", 1)

    modules_list = [
        module_1,
        module_2,
        module_3,
        module_4
    ]
    write_rtlil_file(modules_list)

    top = Top()
    write_top_rtlil(top)

