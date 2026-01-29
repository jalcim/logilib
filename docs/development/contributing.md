# Contributing

Guidelines for contributing to logilib.

## Commits

Commit messages should follow [conventional commit rules](https://www.conventionalcommits.org/en/v1.0.0/#specification) with the [config conventional types](https://github.com/conventional-changelog/commitlint/tree/master/%40commitlint/config-conventional).

### Format

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### Types

| Type | Description |
|------|-------------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation |
| `style` | Formatting |
| `refactor` | Code refactoring |
| `test` | Adding tests |
| `chore` | Maintenance |

### Examples

```
feat(tensor): add matrix multiplication module
fix(mux): correct bit ordering for WAY > 8
docs(alu): add schematic for comparator
test(routing): add demux edge cases
```

## Co-simulation

### CMake

In each new `CMakeLists.txt`, include the environment and call `INIT_ENVIRONMENT()`:

```cmake
include(environment)

INIT_ENVIRONMENT()
```

### Logs

Logs are handled with [Boost trivial logging](https://www.boost.org/doc/libs/1_83_0/libs/log/doc/html/index.html):

```cpp
#include <boost/log/trivial.hpp>

BOOST_LOG_TRIVIAL(info) << "Test started";
BOOST_LOG_TRIVIAL(debug) << "Value: " << result;
BOOST_LOG_TRIVIAL(error) << "Test failed";
```

Log levels: `trace`, `debug`, `info`, `warning`, `error`, `fatal`

## Code Style

### Verilog

- Use structural design (no `always @*` behavioral)
- Parameters: `WAY`, `WIRE` naming convention
- Include guards: `` `ifndef __MODULE_NAME__ ``
- Indent: 3 spaces

### Example

```verilog
`ifndef __MY_MODULE__
 `define __MY_MODULE__

module my_module(out, in);
   parameter WAY = 2;
   parameter WIRE = 1;

   input [WAY*WIRE-1:0] in;
   output [WIRE-1:0] out;

   // Structural implementation
   // ...

endmodule

`endif
```

## Testing

1. Add Icarus test in `test/` mirroring `src/` structure
2. Add Verilator test in `cosim/` if applicable
3. Run tests before submitting:

```bash
./scripts/icarus.sh
./scripts/run_tests.sh
```

## Pull Requests

1. Fork the repository
2. Create feature branch: `git checkout -b feat/my-feature`
3. Make changes and test
4. Commit with conventional format
5. Push and create PR

## Issues

Report bugs at: https://gitlab.com/jalcim/logilib/-/issues
