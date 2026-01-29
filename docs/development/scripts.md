# Scripts

Build, test, and synthesis automation scripts.

## Overview

| Script | Description |
|--------|-------------|
| `icarus.sh` | Run Icarus Verilog tests |
| `run_tests.sh` | Run Verilator co-simulation tests |
| `yosys.sh` | Run Yosys synthesis |
| `lib.sh` | Library path helper (deprecated) |

## icarus.sh

Runs all Icarus Verilog simulation tests.

```bash
./scripts/icarus.sh
```

**What it does:**
1. Finds all test files in `test/`
2. Compiles each with `iverilog`
3. Runs simulation with `vvp`
4. Reports pass/fail status

## run_tests.sh

Runs Verilator co-simulation tests after build.

```bash
./scripts/run_tests.sh
```

**Requirements:** Build must be completed first.

```bash
cmake -S. -Bbuild -GNinja
cmake --build build
./scripts/run_tests.sh
```

## yosys.sh

Runs Yosys synthesis flow.

```bash
./scripts/yosys.sh
```

**Output:**
- `synth/verilog/` - Synthesized Verilog
- `synth/spice/` - SPICE netlists
- `synth/rtlil/` - RTLIL intermediate

## Yosys TCL Scripts

Located in `scripts/yosys/`:

| Script | Description |
|--------|-------------|
| `all.tcl` | Main entry point |
| `utils.tcl` | Helper functions |
| `primitive/gate/*.tcl` | Gate synthesis |
| `routing/*.tcl` | Routing synthesis |
| `memory/*.tcl` | Memory synthesis |
| `alu/arithm/*.tcl` | ALU synthesis |

### Configuration

Edit `scripts/yosys/all.tcl`:

```tcl
set WAY  2    ;# Number of gate inputs
set WIRE 32   ;# Bit width
```

## Manager GUI

Python/GTK3 graphical interface for project management.

```bash
./scripts/manager/manager.py
```

See [Manager GUI](manager.md) for details.

### Structure

```
scripts/manager/
├── manager.py           # Entry point
├── config/
│   └── options.json     # Configuration options
├── gui/
│   └── main_window.py   # GTK window
└── utils/
    └── ...              # Utilities
```

## Directory Structure

```
scripts/
├── icarus.sh            # Icarus test runner
├── run_tests.sh         # Verilator test runner
├── yosys.sh             # Synthesis entry point
├── lib.sh               # Library helper (deprecated)
├── README.md            # Scripts documentation
├── manager/             # GUI application
│   ├── manager.py
│   ├── config/
│   ├── gui/
│   └── utils/
└── yosys/               # Yosys TCL scripts
    ├── all.tcl
    ├── utils.tcl
    ├── alu/
    ├── compteur/
    ├── memory/
    ├── primitive/
    └── routing/
```
