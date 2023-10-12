#ifndef __COSIM_ADDX_TEMPLATE_H__
#define __COSIM_ADDX_TEMPLATE_H__
#include <typeinfo>
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include <cmath>
#include <fstream>
#include <boost/log/trivial.hpp>
#include "addx_macros.h"
#include "addx_test.h"

using namespace std;

extern VerilatedContext *contextp;

const string LOG_PATH_PREFIX = "build/cosim/alu/arithm/";
const string LOG_PATH_SUFFIX = "_check";
const string LOG_TRACE_SUFFIX = "_trace.vcd";
const unsigned int nb_operands = 3;
const unsigned int nb_tests = 18;

char const *get_result_text(bool result_error, bool cout_error)
{
  if (result_error && cout_error)
    return "invalid result and cout";
  else if (result_error)
    return "invalid result";
  else if (cout_error)
    return "invalid cout";
  return "success";
}

template <class VADDX>
class ADDX_TEST
{
  int log_fd;
  std::ofstream log_file_stream;
  unsigned int wires_number;
  string log_path;
  const char *name;
  VADDX *addx;
  t_addx_test *test_fn;
  string trace_path;
  VerilatedVcdC *m_trace = NULL;

public:
  ADDX_TEST(t_addx_test *addx_test, unsigned int wires)
  {
    name = typeid(addx).name();
#ifdef VCD_TRACE_ON
    contextp->traceEverOn(true);
#endif
    addx = new VADDX{contextp};
    test_fn = addx_test;
    wires_number = wires;
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
      addx->trace(m_trace, 99);
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
    bool test_error = false;
    unsigned int operandA = 0;
    unsigned int operandB = 0;
    unsigned int cin = 0;
    unsigned int waited_results[2];
    bool result_error;
    bool cout_error;
    bool error;
    char const *result_text;
    unsigned int max_int = (pow(2, wires_number - 1)) + ((pow(2, wires_number - 1)) - 1);
    unsigned int test_inputs[nb_tests][nb_operands] = {
        {0, 0, 0},
        {0, 0, 1},
        {0, 1, 1},
        {1, 0, 1},
        {1, 1, 1},
        {max_int / 3, max_int / 3, 0},
        {max_int / 3, max_int / 3, 1},
        {max_int / 4, max_int / 4, 0},
        {max_int / 4, max_int / 4, 1},
        {max_int, 0, 0},
        {max_int, 0, 1},
        {max_int, 1, 0},
        {max_int, 1, 1},
        {max_int / 2, max_int / 2, 0},
        {max_int / 2, max_int / 2, 1},
        {max_int / 2 + 1, max_int / 2, 0},
        {max_int / 2, max_int / 2 + 1, 1},
        {max_int / 2 + 1, max_int / 2 + 1, 1},
    };

    BOOST_LOG_TRIVIAL(info)
        << "# Test " << name << " : ";

    if (m_trace)
    {
      m_trace->dump(contextp->time());
      contextp->timeInc(VERILATOR_TIME_INCREMENT);
    }

    int i = 0;
    while (i < nb_tests)
    {
      operandA = test_inputs[i][0];
      operandB = test_inputs[i][1];
      cin = test_inputs[i][2];

      contextp->timeInc(VERILATOR_TIME_INCREMENT);

      BOOST_LOG_TRIVIAL(debug)
          << "Test input A="
          << operandA
          << " B="
          << operandB
          << " CIN="
          << cin
          << " MAX_INT="
          << max_int
          << " : ";

      addx->a = operandA;
      addx->b = operandB;
      addx->cin = cin;

      addx->eval();

      test_fn(waited_results, max_int, operandA, operandB, cin, wires_number);

      result_error = addx->out != waited_results[0];
      cout_error = addx->cout != waited_results[1];
      error = result_error || cout_error;
      result_text = get_result_text(result_error, cout_error);

      BOOST_LOG_TRIVIAL(trace)
          << "OUT wait = res : "
          << waited_results[0]
          << ", "
          << waited_results[1]
          << " = "
          << (unsigned int)addx->out << ", "
          << (unsigned int)addx->cout << " : "
          << result_text;

      log_to_file(result_text, waited_results, max_int);

      test_error |= cout_error;

      if (error)
      {
        log_error(result_text, waited_results, max_int);
      }
      else
      {
        BOOST_LOG_TRIVIAL(debug) << "A=" << operandA << ", B=" << operandB << ", CIN" << cin << " : " << result_text;
      }

      if (m_trace)
        m_trace->dump(contextp->time());

      i++;
    }

    if (test_error)
    {
      BOOST_LOG_TRIVIAL(error) << name << " : " << RES_TEXT(test_error);
    }
    else
    {
      BOOST_LOG_TRIVIAL(info) << name << " : " << RES_TEXT(test_error);
    }

    if (m_trace)
    {
      contextp->timeInc(VERILATOR_TIME_INCREMENT);
      m_trace->dump(contextp->time());
      m_trace->flush();
    }

    return (test_error);
  }

  string format_log(char const *result_text, unsigned int *waited_result, unsigned int max_int)
  {
    std::stringstream ss;

    ss << "Test " << name << " : "
       << result_text
       << " max_int="
       << max_int
       << ", operandA="
       << (unsigned int)addx->a
       << ", operandB="
       << (unsigned int)addx->b
       << ", cin="
       << (unsigned int)addx->cin
       << ", out="
       << (unsigned int)addx->out
       << ", cout="
       << (unsigned int)addx->cout
       << " | waited_result : out="
       << waited_result[0]
       << ", cout="
       << waited_result[1];

    return ss.str();
  }

  void log_to_file(char const *result_text, unsigned int *waited_result, unsigned int max_int)
  {
    log_file_stream << format_log(result_text, waited_result, max_int) << endl;
  }

  void log_error(char const *result_text, unsigned int *waited_result, unsigned int max_int)
  {
    BOOST_LOG_TRIVIAL(error)
        << format_log(result_text, waited_result, max_int) << "\nLogs in : " << log_path;
  }

  ~ADDX_TEST(void)
  {
    delete addx;
    addx = NULL;
    log_file_stream.close();
    close_trace();
  }
};
#endif /* __COSIM_ADDX_TEMPLATE_H__ */
