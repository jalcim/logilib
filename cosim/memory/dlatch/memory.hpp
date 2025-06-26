#pragma once

#include <cmath>
#include <fstream>
#include <iostream>
#include <sstream>
#include <typeinfo>
#include <boost/log/trivial.hpp>
#include <verilated.h>
#include <verilated_vcd_c.h>

extern VerilatedContext *contextp;

const std::string LOG_PATH_PREFIX = "build/cosim/memory/Dlatch/Dlatch";
const std::string LOG_PATH_SUFFIX = "_check";
const std::string LOG_TRACE_SUFFIX = "_trace.vcd";

template <class VDLATCH>
class DLATCH_TEST
{
  int error;
  int log_fd;
  std::ofstream log_file_stream;
  int way_number;
  std::string log_path;
  const char *name;
  VDLATCH *Dlatch;

  int (*test_fn)(int input, int clk);
  std::string trace_path;
#ifdef VCD_TRACE_ENABLED
  VerilatedVcdC *m_trace;
#endif
}
