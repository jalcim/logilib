#!/bin/sh


if [ $# -eq 0 ]
then
  echo "File is missing"
  exit 1
fi

if command -v indent > /dev/null 2>&1;
then
  format=indent
elif command -v clang-format  > /dev/null 2>&1;
then
  format=clang-format
else
  echo "Please install clang-format or indent"
  exit 2
fi

cd build && make -j $1.i && cat CMakeFiles/Vmain.dir/$1.i | $format
