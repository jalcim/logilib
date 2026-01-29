# Manager GUI

Python/GTK3 interface for project management.

## Launch

```bash
./scripts/manager/manager.py
```

## Requirements

```bash
# Fedora
sudo dnf install python3-gobject gtk3

# Ubuntu/Debian
sudo apt install python3-gi gir1.2-gtk-3.0
```

## Features

| Button | Action |
|--------|--------|
| Build | CMake + Ninja build |
| Build Advanced | Module selection + configuration |
| Cosimulation | Run Vgate-tests |
| Simulation | Run Icarus tests |

## Configuration

Options in `scripts/manager/config/options.json`:

- `LOG_LEVEL` - Logging level
- `MAX_WAYS` - Max gate ways
- `VERILATOR_TIME_STEP` - Simulation time step
- `ENABLE_VCD` - VCD trace generation
- Boost library options
