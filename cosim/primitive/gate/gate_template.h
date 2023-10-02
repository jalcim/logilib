#ifndef __COSIM_GATE_TEMPLATE_H__
#define __COSIM_GATE_TEMPLATE_H__
#include <typeinfo>
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include <cmath>
#include <fstream>
#include <boost/log/trivial.hpp>
#include "gate_macros.h"

using namespace std;

extern VerilatedContext *contextp;

const string LOG_PATH_PREFIX = "build/cosim/primitive/gate/gate";
const string LOG_PATH_SUFFIX = "_check";
const string LOG_TRACE_SUFFIX = "_trace.vcd";

template <class VGATE>
class GATE_TEST
{
  int error;
  int log_fd;
  std::ofstream log_file_stream;
  int way_number;
  string log_path;
  const char *name;
  VGATE *gate;
  int (*test_fn)(int input, int way);
  string trace_path;
  VerilatedVcdC *m_trace;

public:
  GATE_TEST(int (*gate_test)(int input, int way), int ways)
  {
    name = typeid(gate).name();
    contextp->traceEverOn(true);
    gate = new VGATE{contextp};
    test_fn = gate_test;
    way_number = ways;
    log_path = LOG_PATH_PREFIX + name + LOG_PATH_SUFFIX;
    log_file_stream.open(log_path, ios::trunc | ios::out);
    trace_path = LOG_PATH_PREFIX + name + LOG_TRACE_SUFFIX;
  }

  void open_trace()
  {
#ifdef VCD_TRACE_ON
    if (!m_trace)
    {
      m_trace = new VerilatedVcdC;
      gate->trace(m_trace, 99);
      m_trace->open(trace_path.c_str());
    }
#endif
  }

  void close_trace(void)
  {
    if (m_trace)
    {
      m_trace->close();
      m_trace = NULL;
    }
  }

  bool test()
  {
    const int input_max = pow(2, way_number);
    bool test_error = false;
    int input = 0;
    int waited_result;
    int result;
    bool error;

    BOOST_LOG_TRIVIAL(info) << "# Test " << name << " : ";

    if (m_trace)
    {
      m_trace->dump(contextp->time());
      contextp->timeInc(VERILATOR_TIME_INCREMENT);
    }

    while (input < input_max)
    {

      contextp->timeInc(VERILATOR_TIME_INCREMENT);
      BOOST_LOG_TRIVIAL(debug) << "Test input " << input << " : ";

      gate->in = input;
      gate->eval();
      waited_result = test_fn(gate->in, way_number) & 1;

      /* fix verilog buffer management */
      result = gate->out & 1;

      BOOST_LOG_TRIVIAL(trace)
          << "OUT wait = res : "
          << waited_result
          << " = "
          << result << " "
          << RESTEXT(result != waited_result);

      error = result != waited_result;
      log_to_file(error, waited_result);

      test_error |= error;

      if (error)
      {
        log_error(error, waited_result);
      }
      else
      {
        BOOST_LOG_TRIVIAL(debug) << input << " : " << RESTEXT(error);
      }

      if (m_trace)
        m_trace->dump(contextp->time());

      input++;
    }

    if (test_error)
    {
      BOOST_LOG_TRIVIAL(error) << name << " : " << RESTEXT(error);
    }
    else
    {
      BOOST_LOG_TRIVIAL(info) << name << " : " << RESTEXT(error);
    }

    if (m_trace)
    {
      contextp->timeInc(VERILATOR_TIME_INCREMENT);
      m_trace->dump(contextp->time());
      m_trace->flush();
    }

    return (test_error);
  }

  // virtual void reset(void)
  // {
  //   gate->i_reset = 1;
  //   // Make sure any inheritance gets applied
  //   this->tick();
  //   gate->i_reset = 0;
  // }

  // virtual void tick(void)
  // {
  //   // Increment our own internal time reference
  //   m_tickcount++;

  //   // Make sure any combinatorial logic depending upon
  //   // inputs that may have changed before we called tick()
  //   // has settled before the rising edge of the clock.
  //   gate->i_clk = 0;
  //   gate->eval();

  //   // Toggle the clock

  //   // Rising edge
  //   gate->i_clk = 1;
  //   gate->eval();e

  //   // Falling edge
  //   gate->i_clk = 0;
  //   gate->eval();
  // }

  string format_log(bool test_error, int waited_result)
  {
    std::stringstream ss;

    ss << "Test " << name << " : "
       << RESTEXT(test_error)
       << " |-> E1="
       << GET_BIT(gate->in, 0)
       << ", E2="
       << GET_BIT(gate->in, 1)
       << ",E3="
       << GET_BIT(gate->in, 2)
       << ",E4="
       << GET_BIT(gate->in, 3)
       << ",E5="
       << GET_BIT(gate->in, 4)
       << ",E6="
       << GET_BIT(gate->in, 5)
       << ",E7="
       << GET_BIT(gate->in, 6)
       << ", out="
       << gate->out
       << "waited_result "
       << waited_result;

    return ss.str();
  }

  void log_to_file(bool test_error, int waited_result)
  {
    log_file_stream << format_log(test_error, waited_result) << endl;
  }

  void log_error(bool test_error, int waited_result)
  {
    BOOST_LOG_TRIVIAL(error)
        << format_log(test_error, waited_result) << "Logs in : " << log_path;
  }

  ~GATE_TEST(void)
  {
    delete gate;
    gate = NULL;
    log_file_stream.close();
    close_trace();
  }
};
#endif /* __COSIM_GATE_TEMPLATE_H__ */
