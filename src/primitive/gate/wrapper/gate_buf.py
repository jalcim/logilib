from amaranth import Elaboratable, Instance, Module

class Gate_buf(Elaboratable):
    def __init__(self, out, in1):
        self.out = clk
        self.in1 = cnt

    def elaborate(self, platform):
        m = Module()
        m.submodules.verilog_counter = Instance(
            "gate_buf",
            i_in1 = self.in1,
            o_out = self.out
        )
        return m
