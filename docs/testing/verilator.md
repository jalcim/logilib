# Verilator Co-simulation

C++ driven tests using Verilator and Boost.Test.

## Requirements

```bash
# Fedora
sudo dnf install verilator boost-devel

# Ubuntu/Debian
sudo apt install verilator libboost-all-dev
```

## Build

```bash
cmake -S. -Bbuild -GNinja
cmake --build build
```

## Run Tests

```bash
# Gate tests
./build/cosim/primitive/gate/Vgate-tests

# Memory tests
./build/cosim/memory/dlatch/VDlatch-tests

# ALU tests
./build/cosim/alu/arithm/addx/Vaddx-tests

# Tensor tests (with CNN reference)
./build/cosim/tensor/cosim_tensor
```

## Test Structure

```
cosim/
├── CMakeLists.txt           # Main CMake config
├── settings.ini             # Test settings
├── alu/
│   └── arithm/
│       ├── addx/            # Adder tests
│       └── add_sub/         # Add/sub tests
├── memory/
│   └── dlatch/              # Latch tests
├── primitive/
│   └── gate/
│       └── parallel/        # Gate tests
├── tensor/
│   ├── cnn/                 # CNN reference implementation
│   └── ...                  # Tensor tests
└── utils/
    └── log.cpp              # Logging utilities
```

## Writing Tests

```cpp
#define BOOST_TEST_MODULE GateTests
#include <boost/test/included/unit_test.hpp>
#include "Vgate_and_2_8.h"

BOOST_AUTO_TEST_CASE(test_gate_and_basic) {
    Vgate_and_2_8 dut;

    // Test: 0xFF AND 0xFF = 0xFF
    dut.in = 0xFFFF;  // {0xFF, 0xFF}
    dut.eval();
    BOOST_CHECK_EQUAL(dut.out, 0xFF);

    // Test: 0xFF AND 0x00 = 0x00
    dut.in = 0xFF00;  // {0x00, 0xFF}
    dut.eval();
    BOOST_CHECK_EQUAL(dut.out, 0x00);
}

BOOST_AUTO_TEST_CASE(test_gate_and_patterns) {
    Vgate_and_2_8 dut;

    // Test: 0xAA AND 0x55 = 0x00
    dut.in = (0x55 << 8) | 0xAA;
    dut.eval();
    BOOST_CHECK_EQUAL(dut.out, 0x00);

    // Test: 0xF0 AND 0xFF = 0xF0
    dut.in = (0xFF << 8) | 0xF0;
    dut.eval();
    BOOST_CHECK_EQUAL(dut.out, 0xF0);
}
```

## Tensor CNN Reference

The `cosim/tensor/cnn/` directory contains a C++ reference implementation for verifying the tensor convolution accelerator:

- Compares hardware output against software convolution
- Tests with various image sizes (9×9, 28×28)
- Validates edge handling (corners, borders, center)

```bash
# Run tensor comparison tests
./build/cosim/tensor/cosim_tensor
```

## Configuration

`cosim/settings.ini`:
```ini
[logging]
level = warning

[verilator]
time_step = 1000
```

## CMake Options

| Option | Description |
|--------|-------------|
| `ENABLE_COSIM` | Enable co-simulation build |
| `ENABLE_VCD` | Enable VCD trace generation |
| `VERILATOR_TIME_STEP` | Simulation time step |

## Location

`cosim/`
