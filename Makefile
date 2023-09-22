######################################################################
#
# DESCRIPTION: Verilator CMake example usage
#
# This file shows usage of the CMake script.
# This makefile is here for testing the examples and should
# generally not be added to a CMake project.
#
# This file ONLY is placed under the Creative Commons Public Domain, for
# any use, without warranty, 2020 by Wilson Snyder.
# SPDX-License-Identifier: CC0-1.0
#
######################################################################

######################################################################
# Set up variables

# If $VERILATOR_ROOT isn't in the environment, we assume it is part of a
# package install, and verilator is in your path. Otherwise find the
# binary relative to $VERILATOR_ROOT (such as when inside the git sources).
######################################################################
ifeq ($(VERILATOR_ROOT),)
VERILATOR = verilator
VERILATOR_COVERAGE = verilator_coverage
else
VERILATOR = $(VERILATOR_ROOT)/bin/verilator
VERILATOR_COVERAGE = $(VERILATOR_ROOT)/bin/verilator_coverage
endif

# Generate C++ in executable form
VERILATOR_ARGS += -cc --exe
# Generate makefile dependencies (not shown as complicates the Makefile)
#VERILATOR_ARGS += -MMD
# Optimize
VERILATOR_ARGS += -x-assign fast
# Warn abount lint issues; may not want this on less solid designs
VERILATOR_ARGS += -Wall
# Make waveforms
VERILATOR_ARGS += --trace
# Check SystemVerilog assertions
VERILATOR_ARGS += --assert
# Generate coverage analysis
VERILATOR_ARGS += --coverage
# Run Verilator in debug mode
#VERILATOR_ARGS += --debug
# Add this trace to get a backtrace in gdb
#VERILATOR_ARGS += --gdbbt

GNUINDENT := `command -v indent`
CLANGFORMAT := `command -v clang-format`

ifneq ($(CLANGFORMAT),)
FORMAT := $(CLANGFORMAT)
else
FORMAT := $(GNUINDENT)
endif

ifeq ($(FORMAT),)
FORMAT_TARGET := noformat
else
FORMAT_TARGET := hasformat
endif


# Check if CMake is installed and of correct version
ifeq ($(shell which cmake),)
TARGET := nocmake
else
CMAKE_VERSION := $(shell cmake --version | grep -Eo '([0-9]+)(\.[0-9]+)*')
CMAKE_MAJOR := $(shell echo $(CMAKE_VERSION) | cut -f1 -d.)
CMAKE_MINOR := $(shell echo $(CMAKE_VERSION) | cut -f2 -d.)
CMAKE_GT_3_8 := $(shell [ $(CMAKE_MAJOR) -gt 3 -o \( $(CMAKE_MAJOR) -eq 3 -a $(CMAKE_MINOR) -ge 12 \) ] && echo true)
ifeq ($(CMAKE_GT_3_8),true)
TARGET := run
else
TARGET := oldcmake
endif
endif


.EXPORT_ALL_VARIABLES:

default: $(TARGET)

build:
	cmake -B build -GNinja ./cosim && ninja -C build

build-make:
	cmake -B build ./cosim && make -C build

run-make: build-make
	./build/Vmain

run: build
	./build/Vmain

hasformat:
	@echo using $(FORMAT)

noformat:
	@echo "Please install clang-format or indent"
	false

%.i: $(FORMAT_TARGET) build-make
	make -C `dirname $@ | sed s/cosim/build/` `basename $@`
	cat `find build -name \`basename $@\`` | $(FORMAT)

clean mostlyclean distclean maintainer-clean:
	@rm -rf build logs

nocmake:
	@echo
	@echo "%Skip: CMake has not been found"
	@echo

oldcmake:
	@echo
	@echo "%Skip: CMake version is too old (need at least 3.8)"
	@echo

.PHONY:  test default build run clean mostlyclean distclean maintainer-clean nocmake oldcmake
