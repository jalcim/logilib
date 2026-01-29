# Co-simulation

Verilator + Boost.Test for hardware/software co-simulation.

## Quick Start

```bash
cmake -S. -Bbuild -GNinja
cmake --build build
```

## Run Tests

```bash
# Gate tests
./build/cosim/primitive/gate/Vgate-tests

# DLatch tests
./build/cosim/memory/dlatch/VDlatch-tests

# Tensor tests
./build/cosim/tensor/cosim_tensor
```

## Structure

```
cosim/
├── CMakeLists.txt
├── settings.ini
├── alu/arithm/          # ALU tests
├── memory/dlatch/       # Memory tests
├── primitive/gate/      # Gate tests
├── tensor/              # Tensor + CNN reference
└── utils/               # Logging utilities
```

## Writing Tests

```cpp
#define BOOST_TEST_MODULE MyTests
#include <boost/test/included/unit_test.hpp>
#include "Vmodule.h"

BOOST_AUTO_TEST_CASE(test_basic) {
    Vmodule dut;
    dut.in = 0xFF;
    dut.eval();
    BOOST_CHECK_EQUAL(dut.out, expected);
}
```

## Detailed Documentation

See [Testing > Verilator](../testing/verilator.md) for comprehensive documentation.
