# Logilib

High-density structural logic library.

## Features

- Fully structural Verilog (no behavioral code)
- Parameterizable modules (WAY, WIRE)
- Zero-latency tensor convolution accelerator
- FuseSoC compatible

## Quick Start

```bash
pip install fusesoc
fusesoc library add logilib https://gitlab.com/jalcim/logilib
```

```verilog
// No include needed with FuseSoC
addX #(.WIRE(8)) adder(.a(a), .b(b), .cin(cin), .out(sum), .cout(cout));
mux #(.WAY(2), .WIRE(8)) mux_inst(.out(out), .in({in1, in0}), .ctrl(sel));
```

## Navigation

- [Installation](installation.md) - Setup FuseSoC and dependencies
- [Getting Started](getting-started.md) - Create your first project
- [Modules](modules/index.md) - Reference documentation
- [Development](development/build.md) - For contributors
