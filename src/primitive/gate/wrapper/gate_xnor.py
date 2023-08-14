from amaranth import Elaboratable, Instance, Module

class Gate_xnor(Elaboratable):
    def __init__(self, out, in1, in2):
        self.out = clk
        self.in1 = cnt
        self.in2 = cnt
        self.ports = [self.out, self.in1, self.in2]

    def elaborate(self, platform):
        m = Module()
        m.submodules.verilog_counter = Instance(
            "gate_xnor",
            i_in1 = self.in1,
            i_in2 = self.in2,
            o_out = self.out
        )
        return m
