# Project Structure

Complete directory layout of the logilib repository.

## Root Directory

```
logilib/
├── src/                 # Verilog source modules
├── test/                # Icarus Verilog testbenches
├── cosim/               # Verilator C++ co-simulation
├── veriform/            # Formal verification
├── scripts/             # Build and automation scripts
├── shema/               # Circuit schematics (PNG)
├── wrapper/             # Language wrappers (Amaranth)
├── docs/                # MkDocs documentation
├── example/             # FuseSoC usage example
├── TODO/                # Work in progress
│
├── logilib.core         # FuseSoC package definition
├── CMakeLists.txt       # CMake build configuration
├── build_config.cmake   # Build options
├── mkdocs.yml           # Documentation config
├── .gitlab-ci.yml       # CI/CD pipeline
├── Dockerfile           # Container build
├── README.md            # Project README
└── README_FR.md         # French README
```

## Source Modules (`src/`)

```
src/
├── alu/                 # Arithmetic Logic Unit
│   ├── arithm/          # Arithmetic operations
│   │   ├── add.v        # 1-bit adder
│   │   ├── addX.v       # N-bit adder
│   │   ├── add_sub.v    # Adder/subtractor
│   │   ├── cmp.v        # Comparator
│   │   ├── divmod2.v    # Division by 2
│   │   ├── multX.v      # Multiplier
│   │   └── mult_cell.v  # Multiplier cell
│   └── logic/           # Logic operations
│       ├── sll.v        # Shift left
│       ├── slt.v        # Set less than
│       ├── sltu.v       # Set less than unsigned
│       └── sra_srl.v    # Shift right
│
├── bus/                 # Bus interfaces
│   └── axi_lite/        # AXI4-Lite
│       ├── master.v
│       ├── slave.v
│       └── regs.v
│
├── compteur/            # Counters
│   └── cpt_bin.v        # Binary counter
│
├── memory/              # Memory elements
│   ├── dflipflop/       # D flip-flops
│   │   ├── Dflipflop.v
│   │   ├── Dflipflop_rst.v
│   │   ├── Dflipflop_pre.v
│   │   ├── Dflipflop_rst_pre.v
│   │   ├── parallel/    # Parallel variants
│   │   └── serial/      # Serial variants
│   ├── dlatch/          # D latches
│   │   ├── Dlatch.v
│   │   ├── Dlatch_rst.v
│   │   ├── Dlatch_pre.v
│   │   ├── Dlatch_rst_pre.v
│   │   ├── parallel/
│   │   └── serial/
│   └── jklatch/         # JK latches
│       └── JKlatch_rst.v
│
├── primitive/           # Basic logic gates
│   └── gate/
│       ├── gate_and.v
│       ├── gate_or.v
│       ├── gate_xor.v
│       ├── gate_nand.v
│       ├── gate_nor.v
│       ├── gate_xnor.v
│       ├── gate_not.v
│       ├── gate_buf.v
│       ├── complex/     # AOI/OAI gates
│       ├── multi/       # Multi-gate arrays
│       ├── parallel/    # Parallel implementations
│       └── serial/      # Serial implementations
│
├── routing/             # Signal routing
│   ├── mux.v            # Multiplexer
│   ├── demux.v          # Demultiplexer
│   ├── encoder.v        # Binary encoder
│   ├── shuffle.v        # Data shuffler
│   ├── replicator.v     # Signal replicator
│   ├── fragmented_replicator.v
│   ├── decalleur_LR.v   # Barrel shifter
│   └── log2.vh          # Log2 function
│
├── tensor/              # Tensor accelerator
│   ├── tensor.v         # Top-level
│   ├── mult.v           # Multiplier array
│   ├── acc.v            # Accumulator
│   ├── adder_tree.v     # Adder tree
│   ├── on_coin.v        # Corner handler
│   ├── on_border.v      # Border handler
│   ├── on_center.v      # Center handler
│   └── mmul.v           # Matrix multiply
│
└── type/                # Data types
    ├── float.v          # IEEE 754 single
    ├── double.v         # IEEE 754 double
    └── fadd.v           # Float adder
```

## Tests (`test/`)

Mirror structure of `src/` with test files:

```
test/
├── alu/arithm/          # ALU tests
├── bus/axi_lite/        # Bus tests
├── compteur/            # Counter tests
├── memory/              # Memory tests
├── primitive/gate/      # Gate tests
├── routing/             # Routing tests
└── tensor/              # Tensor tests
```

## Co-simulation (`cosim/`)

```
cosim/
├── CMakeLists.txt
├── settings.ini
├── alu/arithm/          # ALU C++ tests
├── memory/dlatch/       # Memory C++ tests
├── primitive/gate/      # Gate C++ tests
├── tensor/              # Tensor C++ tests
│   └── cnn/             # CNN reference
└── utils/               # Test utilities
```

## Schematics (`shema/`)

Circuit diagrams in PNG format:

```
shema/
├── alu/arithm/          # ALU schematics
├── compteur/            # Counter schematics
├── memory/              # Memory schematics
├── primitive/           # Gate schematics
├── routing/             # Routing schematics
└── spi/                 # SPI schematics
```

## Scripts (`scripts/`)

```
scripts/
├── icarus.sh            # Icarus runner
├── run_tests.sh         # Cosim runner
├── yosys.sh             # Synthesis runner
├── manager/             # GUI application
└── yosys/               # TCL scripts
```
