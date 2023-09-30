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



# must be updated with each module_type
ALLOWED_PARAMS = {
    "gate_and": ["p_WAY", "p_WIRE"],
    "gate_or": ["p_WAY", "p_WIRE"],
    "gate_xor": ["p_WAY", "p_WIRE"],
    "gate_not": ["p_WIRE"],
    "gate_nand": ["p_WAY", "p_WIRE"],
    # new module types must be added above this
    "default": ["p_WAY", "p_WIRE"], # define defaut required parameters
}

class Module(am.Elaboratable): # this is a recursive Element

    unique_id = 0 # auto increment
    ports = []
    data = {}
    name = "default"
    submodules_list = []

    # sit to remove
    reg_in = False
    reg_out = False

    def __init__(
            self,
            # reg_out, # who shat here ? need better generic class
            # is it important to define it now ?
            # and not just before rtlil generation ?
            module_type : str = "default",
            # params : dict = {},
            **kwargs
    ):
        self.data = kwargs
        self.name = module_type + "_" + str(Module.unique_id)
        self.module_type = module_type

        # DO NOT INITIALIZE signals at Module.__init__()
        """
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
        """

        #to_copy = ALLOWED_PARAMS[self.module_type if self.module_type in ALLOWED_PARAMS.keys() else "default"]
        #self.params.update({"p_" + key: value for key, value in self.data.items() if key in to_copy})

        # NOT HERE
        """
        self.module = Verilog_module(
            reg_in, reg_out,
            self.module_type,
            str(Module.unique_id),
            **self.params,
        )
        """
        # nothing below increment
        Module.unique_id += 1

    def check_module_type(self, module_type, params):
        required_parameters = ALLOWED_PARAMS[module_type] if module_type in ALLOWED_PARAMS.keys() else ALLOWED_PARAMS["default"]
        for req_param in required_parameters:
            if req_param not in params.keys():
                raise Exception(f"'{module_type}' module type must explicit '{req_param}' parameter.")

    def init_sig(self, sig_name : str):
        # auto init signal with correct size
        value = None
        if sig_name == "i_in":
            if self.module_type in ["gate_or", "gate_and", "gate_nand"]:
                value = (self.data["p_WAY"] * self.data["p_WIRE"])
            else:
                value = am.Signal(self.data["p_WIRE"])
        elif sig_name == "o_out":
            value = am.Signal(self.data["p_WIRE"])
        if value is not None:
            self.set(sig_name, value)


    def add_submodules(self, new_modules : list):
        for mod in new_modules:
            self.submodules_list.append(mod)

    def get(self, key):
        return self.data.get(key)

    def set(self, key : str, value):
        self.data[key] = value

    def write_rtlil_file(self):
        #name = "module" # must generate the name from object
        platform = None
        emit_src = True
        strip_internal_attrs = False
        fragment = Fragment.get(self, platform).prepare(ports=self.ports)
        rtlil_text, name_map = convert_fragment(
            fragment,
            self.name,
            emit_src=emit_src,
        )
        ENV_USERNAME = environ.get("USER")
        rtlil_source_text = rtlil_text.replace(ENV_USERNAME, "user")
        now = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
        filename = self.name + "_" + now + ".rtlil"
        with open(filename, "w") as fd:
            fd.write(rtlil_source_text)
            print(f"{filename} file written.")

    def finish_prefab(self, recursive = False):
        self.params = {}
        for key, value in self.data.items():
            if key[0:2] in ["p_"]:
                self.params[key] = value

        self.ports = []
        for key in self.data.keys():
            if self.reg_in == False :
                #print("1")
                if key[0:2] in ["o_"] or key[0:3] in ["io_"]:
                    self.ports.append(self.data.get(key))
            elif self.reg_out == False :
                #print("2")
                if key[0:2] in ["i_"] or key[0:3] in ["io_"]:
                    self.ports.append(self.data.get(key))
            else :
                #print("3")
                if key[0:2] in ["i_", "o_"] or key[0:3] in ["io_"]:
                    self.ports.append(self.data.get(key))

        if recursive is True:
            for sub_mod in self.submodules_list:
                 sub_mod.finish_prefab(recursive=recursive)

    def elaborate(self, platform):
        top = am.Module()
        self.ports = []
        for sub_mod in self.submodules_list:
            verilog = am.Instance(
                sub_mod.module_type,
                **sub_mod.data
            )
            setattr(top.submodules, f"{sub_mod.module_type}_{Module.unique_id}.verilog", verilog)
            Module.unique_id += 1
            for pin in sub_mod.ports:
                self.ports.append(pin)
            for port in self.ports:
                top.ports.append(port)
        return top









if __name__ == "__main__":
    # exemple 2 : modules relier dans un top

    # first, declare elements
    top_mod1 = Module("gate_and", p_WAY=2, p_WIRE=1)
    top_mod2 = Module("gate_and", p_WAY=2, p_WIRE=1)
    top_mod3 = Module("gate_and", p_WAY=2, p_WIRE=1)
    top = Module("top", p_WAY=8, p_WIRE=8)

    # plug
    top.add_submodules([top_mod1, top_mod2, top_mod3])


    # now we have to rely some entries
    top_mod1.set("p_WAY", 2)
    top_mod1.set("p_WIRE", 1)
    #top_mod1.reg_out = False
    top_mod2.set("p_WAY", 2)
    top_mod2.set("p_WIRE", 1)
    #top_mod2.reg_out = False
    top_mod3.set("p_WAY", 2)
    top_mod2.set("p_WIRE", 1)
    #top_mod3.reg_out = True
    top.set("p_WAY",  8)
    top.set("p_WIRE", 8)



    # here, we have to rely all elements correctly, AFTER initialisation
    top_mod1.init_sig("o_out")
    top_mod2.init_sig("o_out")
    top_mod3.set("i_in", am.Cat(top_mod1.get("o_out"), top_mod2.get("o_out")))
    # ...


    # now plug to top in/out
    # ...


    top.finish_prefab(recursive=False) # fill empty i_ / o_, following reg_in/reg_out pattern

    print("SUBMOD LIST", top.submodules_list)
    #print("SUBMOD S", top.submodules)
    # fnally
    top.write_rtlil_file()
