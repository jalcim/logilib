# Testing Overview

Logilib uses multiple testing strategies to ensure correctness.

## Testing Methods

| Method | Tool | Location | Description |
|--------|------|----------|-------------|
| Simulation | Icarus Verilog | `test/` | Behavioral testbenches |
| Co-simulation | Verilator + Boost | `cosim/` | C++ driven tests |
| Formal | SymbiYosys | `veriform/` | Property verification |

## Quick Start

### Run Icarus Tests
```bash
./scripts/icarus.sh
```

### Run Verilator Co-simulation
```bash
cmake -S. -Bbuild -GNinja
cmake --build build
./build/cosim/primitive/gate/Vgate-tests
```

### Run Formal Verification
```bash
cd veriform/alu/arithm
sby -f addX.sby
```

## Test Coverage

| Module | Icarus | Verilator | Formal |
|--------|--------|-----------|--------|
| Primitive gates | Yes | Yes | - |
| Routing | Yes | - | Yes |
| Memory | Yes | Yes | - |
| ALU | Yes | Yes | Yes |
| Tensor | Yes | Yes | - |
| Counter | Yes | - | - |
| Bus | Yes | - | - |

## Directory Structure

```
test/                    # Icarus Verilog testbenches
├── alu/                 # ALU tests
├── bus/                 # Bus interface tests
├── compteur/            # Counter tests
├── memory/              # Memory element tests
├── primitive/           # Gate tests
├── routing/             # Routing tests
└── tensor/              # Tensor tests

cosim/                   # Verilator co-simulation
├── alu/                 # ALU C++ tests
├── memory/              # Memory C++ tests
├── primitive/           # Gate C++ tests
├── tensor/              # Tensor C++ tests (with CNN reference)
└── utils/               # Test utilities

veriform/                # Formal verification
├── alu/                 # ALU properties
└── routing/             # Routing properties
```
