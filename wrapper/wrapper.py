#!/usr/bin/env python3

from os import environ
import datetime

import amaranth as am
# from amaranth import Signal, Module, Instance
from amaranth.back import rtlil
from amaranth.hdl import ir
from amaranth.hdl.ir import Fragment
from amaranth.back.rtlil import convert_fragment

from collections import defaultdict, OrderedDict

class Verilog_module():
    def __init__(self, reg_in, reg_out, name, id, **kwargs):
        self.reg_in = reg_in
        self.reg_out = reg_out
        self.kwargs = kwargs
        self.name = name
        self.rtlil_source = "" #affectation dans write_rtlil_file
        self.rtlil_file = self.name + id + ".rtlil"
        #print("reg_in", reg_in)
        #print("reg_out", reg_out)
        self.update_prefab()

    def update_prefab(self):
        self.params = []
        for key in self.kwargs.keys():
            if key[0:2] in ["p_"]:
                self.params.append(self.kwargs.get(key))

        self.ports = []
        for key in self.kwargs.keys():
            if self.reg_in == False :
                #print("1")
                if key[0:2] in ["o_"] or key[0:3] in ["io_"]:
                    self.ports.append(self.kwargs.get(key))
            elif self.reg_out == False :
                #print("2")
                if key[0:2] in ["i_"] or key[0:3] in ["io_"]:
                    self.ports.append(self.kwargs.get(key))
            else :
                #print("3")
                if key[0:2] in ["i_", "o_"] or key[0:3] in ["io_"]:
                    self.ports.append(self.kwargs.get(key))

# must be updated with each module_type
ALLOWED_PARAMS = {
    "gate_and": ["WAY", "WIRE"],
    "gate_or": ["WAY", "WIRE"],
    "gate_xor": ["WAY", "WIRE"],
    "gate_not": ["WIRE"],
    "gate_nand": ["WAY", "WIRE"],
}

class Module():

    module_id = 0 # auto increment

    def check_module_type(self, module_type, params):
        for required_param in ALLOWED_PARAMS[module_type]:
            if required_param not in params.keys():
                raise Exception(f"'{module_type}' module type must explicit '{required_param}' parameter.")

    def __init__(self, reg_out, module_type : str, params : dict, **kwargs):
        self.check_module_type(module_type, params)
        self.params = {}
        self.module_type = module_type
        if "i_in" not in kwargs.keys():
            reg_in = True
            if self.module_type in ["gate_or", "gate_and", "gate_nand"]:
                self.params["i_in"] = am.Signal(params["WAY"] * params["WIRE"])
                self.params["o_out"] = am.Signal(params["WIRE"])
            elif self.module_type == "gate_not":
                self.params["i_in"] = am.Signal(params["WIRE"])
                self.params["o_out"] = am.Signal(params["WIRE"])

        else :
            reg_in = False
            if self.module_type in ["gate_or", "gate_and", "gate_nand", "gate_not"]:
                self.params["i_in"] = kwargs.get("i_in"),
                self.params["o_out"] = am.Signal(params["WIRE"])

        # override explicit kwargs
        for key,value in kwargs.items():
            #print(key, value)
            if value is not None: # avoid None kwargs initialization
                self.params[key] = value

        self.params.update({"p_" + key: value for key, value in params.items() if key in ALLOWED_PARAMS[self.module_type]})

        self.module = Verilog_module(
            reg_in, reg_out,
            self.module_type,
            str(Module.module_id),
            **self.params,
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
            #print(f"'{elem.module.rtlil_file}' filename written.")


def write_rtlil(module : am.Elaboratable):
    name = "module" # must generate the name from object
    platform = None
    emit_src = True
    strip_internal_attrs = False
    fragment = Fragment.get(module, platform).prepare(ports=module.ports)
    rtlil_text, name_map = convert_fragment(
        fragment,
        name,
        emit_src=emit_src,
    )
    ENV_USERNAME = environ.get("USER")
    rtlil_source_text = rtlil_text.replace(ENV_USERNAME, "user")
    now = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    filename = name + "_" + now + ".rtlil"
    with open(filename, "w") as fd:
        fd.write(rtlil_source_text)
        print(f"{filename} file written.")


class Top(am.Elaboratable):
    def __init__(self, modules_list : list = []):
        self.modules_list = modules_list

    def elaborate(self, platform):
        top = am.Module()
        self.ports = []
        unique_id = 1
        for mod in self.modules_list:
            verilog = am.Instance(
                mod.module_type,
                **mod.params
            )
            setattr(top.submodules, f"{mod.module_type}_{unique_id}.verilog", verilog)
            unique_id += 1
            for pin in mod.module.ports:
                self.ports.append(pin)
        return top

    def get(self, key): ## REMOVE THIS SHIT ONCE INHERITS FROM Module()
        return am.Signal(1) ## REMOVE THIS SHIT ONCE INHERITS FROM Module()

    def set(self, key, value): ## REMOVE THIS SHIT ONCE INHERITS FROM Module()
        pass ## REMOVE THIS SHIT ONCE INHERITS FROM Module()

if __name__ == "__main__":
    # exemple 2 : modules relier dans un top
    #print("top1")
    top_mod1 = Module(False, "gate_and", {"WAY": 2, "WIRE": 1})
    #print("top2")
    top_mod2 = Module(False, "gate_and", {"WAY": 2, "WIRE": 1})
    #print("top3")
    top_mod3 = Module(True, "gate_and", {"WAY": 2, "WIRE": 1}, i_in=am.Cat(top_mod1.get("o_out"), top_mod2.get("o_out")))

    top = Top(modules_list = [top_mod1, top_mod2, top_mod3])
    write_rtlil(top)
