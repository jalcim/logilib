#!/bin/sh

mkdir build
cmake -S cosim -B build
cd build
make -j
