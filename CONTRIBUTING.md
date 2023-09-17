# Macros

## X-Macros

X-Macros are used to repeat a macro on a list of variables.

You can have detailled explanation about their behavior there [X-Macros](https://www.geeksforgeeks.org/x-macros-in-c/)

## Debugging

Macro could reduce readability for debugging even if macros in this repo should be short and readable to avoid problems.

In case you need a more clear view on the preprocesed code use the `./scripts/expand_macro.sh`

E.g. to see `cosim/primitive/gate/gate.cpp` preprocessed run

```sh
./scripts/expand_macro.sh primitive/gate/gate.cpp
```

Please note you need to install [gnu-indent](https://www.gnu.org/software/indent/) or [clang-complete](https://clang.llvm.org/docs/ClangFormat.html)
