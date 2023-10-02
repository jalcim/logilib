# Build

## Simulation

Build of simulation by running in the root folder

```
./script/icarus.sh
```
Result files are on bin/

## Co-simulation

Build of co-simulation library by running in the root folder

```sh
./scripts/verilator.sh
```
Result files are on build/

## Partial build

To build only a part of cosim you may use this kind of command from root of logilib

Example for build alu lib

```sh
touch cosim/alu && make cosim/alu/build
```


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

### MAX_WAYS

Set max number of gates ways generated, default 8
When changing you need to comment/uncomment corresponding macros in [gate_macros.h](cosim/primitive/gate/gate_macros.h) and includes in [gate_includes.h](cosim/primitive/gate/gate_includes.h)

