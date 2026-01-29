# Modules Overview

## Parameters

| Parameter | Description |
|-----------|-------------|
| `WAY` | Number of input ways (e.g., 2 for 2-input gate) |
| `WIRE` | Bit width of each way |

## Module Reference

### Primitive Gates

| Module | Parameters | Description |
|--------|------------|-------------|
| `gate_and` | WAY, WIRE | AND gate |
| `gate_or` | WAY, WIRE | OR gate |
| `gate_xor` | WAY, WIRE | XOR gate |
| `gate_nand` | WAY, WIRE | NAND gate |
| `gate_nor` | WAY, WIRE | NOR gate |
| `gate_xnor` | WAY, WIRE | XNOR gate |
| `gate_not` | WIRE | NOT gate (inverter) |
| `gate_buf` | WIRE | Buffer |
| `gate_ao` | - | AND-OR-Invert |
| `gate_oa` | - | OR-AND-Invert |
| `multi_or` | NB_GATE, WAY, WIRE | Multiple OR gates |

### Routing

| Module | Parameters | Description |
|--------|------------|-------------|
| `mux` | WAY, WIRE | Multiplexer |
| `demux` | WAY, WIRE | Demultiplexer |
| `encoder` | SIZE_ADDR | Binary encoder |
| `shuffle` | WAY, WIRE | Data shuffler |
| `replicator` | WAY, WIRE | Signal replicator |
| `fragmented_replicator` | WAY, WIRE | Fragmented replicator |
| `decalleur_LR` | WIRE | Left/right shifter |

### Memory

| Module | Parameters | Description |
|--------|------------|-------------|
| `Dlatch` | WAY, WIRE | D latch |
| `Dlatch_rst` | WAY, WIRE | D latch with reset |
| `Dlatch_pre` | WAY, WIRE | D latch with preset |
| `Dlatch_rst_pre` | WAY, WIRE | D latch with reset + preset |
| `Dflipflop` | WAY, WIRE | D flip-flop |
| `Dflipflop_rst` | WAY, WIRE | D flip-flop with reset |
| `Dflipflop_pre` | WAY, WIRE | D flip-flop with preset |
| `Dflipflop_rst_pre` | WAY, WIRE | D flip-flop with reset + preset |
| `JKlatch_rst` | - | JK latch with reset |

### ALU - Arithmetic

| Module | Parameters | Description |
|--------|------------|-------------|
| `addX` | WIRE | N-bit adder |
| `add` | - | 1-bit full adder |
| `add_sub` | WIRE | Adder/subtractor |
| `multX` | WIRE, ELEM | Multiplier |
| `mult_cell` | - | Multiplier cell |
| `cmp` | WIRE | Comparator |
| `divmod2` | WIRE | Division/modulo by 2 |

### ALU - Logic

| Module | Parameters | Description |
|--------|------------|-------------|
| `sll` | WIRE | Shift left logical |
| `slt` | WIRE | Set less than (signed) |
| `sltu` | WIRE | Set less than (unsigned) |
| `sra_srl` | WIRE | Shift right arithmetic/logical |

### Tensor

| Module | Parameters | Description |
|--------|------------|-------------|
| `tensor` | DATA_WIDTH, IMG_MAX_X/Y, CONV_MAX_X/Y | 2D convolution |
| `mult` | DATA_WIDTH, IMG_SIZE, CONV_SIZE | Multiplication engine |
| `acc` | DATA_WIDTH, IMG_MAX_X/Y, CONV_MAX_X/Y | Accumulator router |
| `adder_tree` | DATA_WIDTH, NB_ELEM | Logarithmic adder |
| `on_coin` | DATA_WIDTH | Corner pixel handler |
| `on_border` | DATA_WIDTH | Border pixel handler |
| `on_center` | DATA_WIDTH | Center pixel handler |
| `mmul` | DATA_WIDTH, DIM_X/Y/Z | Matrix multiplication |

### Bus

| Module | Parameters | Description |
|--------|------------|-------------|
| `axi4_master` | - | AXI4-Lite master |
| `axi4_slave` | - | AXI4-Lite slave |
| `regs` | - | Register bank |

### Counter

| Module | Parameters | Description |
|--------|------------|-------------|
| `cpt_bin` | SIZE | Binary up-counter |

### Types

| Module | Parameters | Description |
|--------|------------|-------------|
| `float` | - | IEEE 754 single-precision |
| `double` | - | IEEE 754 double-precision |
| `fadd` | - | Float adder |

## Detailed Documentation

- [Primitive Gates](primitive.md)
- [Routing](routing.md)
- [Memory](memory.md)
- [ALU](alu.md)
- [Tensor](tensor.md)
- [Bus (AXI-Lite)](bus.md)
- [Counter](compteur.md)
- [Types](type.md)
- [Misc](misc.md)
