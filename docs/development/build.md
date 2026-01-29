# Build

## Requirements

- CMake 3.28+
- Ninja
- Verilator
- Boost (log, unit_test_framework)

## Quick Build

```bash
cmake -S. -Bbuild -GNinja
cmake --build build
```

## Configuration

Edit `build_config.cmake` or use the GUI manager:

```bash
./scripts/manager/manager.py
```

## Options

| Option | Description |
|--------|-------------|
| `ENABLE_SRC` | Enable source compilation |
| `ENABLE_COSIM` | Enable co-simulation |
| `ENABLE_VCD` | Enable VCD trace generation |
| `STATIC_BUILD` | Static linking |
| `MAX_WAYS` | Max gate ways to generate |
| `MAX_WIRE` | Max wire width to generate |

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `LOG_LEVEL` | Log level | warning |
| `VERILATOR_TIME_STEP` | Time step | 1000 |
