graphical interface
./scripts/manager/manager.py

# Description

Logilib is high density and performance logic library developped on a fully structural way.
The objective is to provide a stdcell library for yosys, highly parameterizable.
In option we provide a POC python (amaranth wrapper) for direct using.
Its a piece of a more big environnement with a logilib/libcmos architecture on top of pdk wrapper.

# Build

## Package as library (for use the library with another circuit)
./script/lib.sh

## Synthesis (first stage)

Synthesis of design for provide final verilog/rtlil usable

```sh
./script/yosys.sh
```
Result files are on synth/

## Simulation

Build of simulation by running in the root folder

```sh
./script/icarus.sh
```
Result files are on bin/

## Synthesis

Build of synthesis by running in the root folder

```sh
make synthesis
```

## Co-simulation

Build of co-simulation library by running in the root folder

```sh
cmake -S. -Bbuild -GNinja && cmake --build build && ./build/cosim/Vgate-tests
```
Result files are on build/

## Environment

### VERILATOR_TIME_INCREMENT

Set time increment on each verilator eval default 1000

### VCD_TRACE_ON

Enable generation of vcd trace files

### COMPILE_STATIC

If defined compile all libraries as static

### LOG_LEVEL

Change log level, allowed values are boost severity levels:

trace
debug
info
warning
error
fatal

### ARITHM_WIRES_LIST

Set list of wire numbers to generate default `1 2 3 4 7 8 16 32`
When changing you need to add corresponding macros in [gate_macros.h](cosim/primitive/gate/gate_macros.h) and includes in [gate_includes.h](cosim/primitive/gate/gate_includes.h)

### GATES_WAYS_LIST

Set list of wire numbers to generate default `2 3 4 7 8`
When changing you need to comment/uncomment corresponding macros in [gate_macros.h](cosim/primitive/gate/gate_macros.h) and includes in [gate_includes.h](cosim/primitive/gate/gate_includes.h)

