# Commits

Commit messages should follow [conventional commit rules](https://www.conventionalcommits.org/en/v1.0.0/#specification) with the [config conventional types](https://github.com/conventional-changelog/commitlint/tree/master/%40commitlint/config-conventional)

# Cosim

## CMake
In each new `CMakeLists.txt` created please include the [environment.cmake](./cosim/cmake/environment.cmake) and call the INIT_ENVIRONMENT() to ensure necessary libraries and defines are present

```cmake
include(environment)

INIT_ENVIRONMENT()
```


## Logs

Logs are handled with [boost trivial logging](https://www.boost.org/doc/libs/1_83_0/libs/log/doc/html/index.html)


## Macros


### X-Macros

X-Macros are used to repeat a macro on a list of variables.

You can have detailled explanation about their behavior there [X-Macros](https://www.geeksforgeeks.org/x-macros-in-c/)


### Debugging

Macro could reduce readability for debugging even if macros in this repo should be short and readable to avoid problems.

In case you need a more clear view on the preprocesed code use the `%.i` Makefile rule

E.g. to see `cosim/primitive/gate/gate.cpp` preprocessed, run

```sh
make cosim/primitive/gate/gate.cpp.i
```

If you build with ninja before (used by default for build) you need to run `make clean` before

Please note you need to install [gnu-indent](https://www.gnu.org/software/indent/) or [clang-complete](https://clang.llvm.org/docs/ClangFormat.html)

