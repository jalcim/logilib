#ifndef __COSIM_ADD_SUB_TEMPLATE_H__
#define __COSIM_ADD_SUB_TEMPLATE_H__
#include <typeinfo>
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include <cmath>
#include <fstream>
#include <boost/log/trivial.hpp>
#include "add_sub_macros.h"
#include "add_sub_test.h"

using namespace std;

extern VerilatedContext *contextp;

const string LOG_PATH_PREFIX = "build/cosim/alu/arithm/";
const string LOG_PATH_SUFFIX = "_check";
const string LOG_TRACE_SUFFIX = "_trace.vcd";
const unsigned int nb_operands = 3;
const unsigned int nb_tests = 22;

char const *get_result_txt(bool result_error, bool cout_error)
{
  if (result_error && cout_error)
    return "invalid result and cout";
  else if (result_error)
    return "invalid result";
  else if (cout_error)
    return "invalid cout";
  return "success";
}

template <class VADD_SUB>
class ADD_SUB_TEST
{
  int log_fd;
  std::ofstream log_file_stream;
  unsigned int wires_number;
  string log_path;
  const char *name;
  VADD_SUB *add_sub;
  t_add_sub_test *test_fn;
  string trace_path;
  VerilatedVcdC *m_trace = NULL;

public:
  ADD_SUB_TEST(t_add_sub_test *add_sub_test, unsigned int wires)
  {
    name = typeid(add_sub).name();
#ifdef VCD_TRACE_ON
    contextp->traceEverOn(true);
#endif
    add_sub = new VADD_SUB{contextp};
    test_fn = add_sub_test;
    wires_number = wires;
    log_path = LOG_PATH_PREFIX + name + LOG_PATH_SUFFIX;
    log_file_stream.open(log_path, ios::trunc | ios::out);
    trace_path = LOG_PATH_PREFIX + name + LOG_TRACE_SUFFIX;
#ifdef VCD_TRACE_ON
    open_trace();
#endif
  }

#ifdef VCD_TRACE_ON
  void open_trace()
  {
    if (!m_trace)
    {
      m_trace = new VerilatedVcdC;
      add_sub->trace(m_trace, 99);
      m_trace->open(trace_path.c_str());
    }
  }

  void close_trace(void)
  {
    if (m_trace)
    {
      m_trace->close();
      m_trace = NULL;
    }
  }
#endif

  bool test(bool is_sub)
  {
    bool test_error = false;
    int operandA = 0;
    int operandB = 0;
    unsigned int cin = 0;
    unsigned int sub = 0;
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
        {max_int / 3, max_int / 3 + 1, 0},
        {max_int / 3, max_int / 3 + 1, 1},
        {max_int / 4, max_int / 4 + 1, 0},
        {max_int / 4, max_int / 4 + 1, 1},
        {max_int, 0, 0},
        {max_int, 0, 1},
        {max_int, 1, 0},
        {max_int, 1, 1},
        {0, max_int, 0},
        {0, max_int, 1},
        {1, max_int, 0},
        {1, max_int, 1},
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
      sub = is_sub ? 1 : 0;

      contextp->timeInc(VERILATOR_TIME_INCREMENT);

      BOOST_LOG_TRIVIAL(debug)
          << "Test input A="
          << operandA
          << " B="
          << operandB
          << " CIN="
          << cin
          << " SUB="
          << sub
          << " MAX_INT="
          << max_int
          << " : ";

      add_sub->a = operandA;
      add_sub->b = operandB;
      add_sub->cin = cin;
      add_sub->sub = sub;
      add_sub->eval();

      test_fn(waited_results, max_int, operandA, operandB, cin, sub, wires_number);

      result_error = add_sub->out != waited_results[0];
      cout_error = add_sub->cout != waited_results[1];
      error = result_error || cout_error;
      result_text = get_result_txt(result_error, cout_error);

      BOOST_LOG_TRIVIAL(trace)
          << "OUT wait = res : "
          << waited_results[0]
          << ", "
          << waited_results[1]
          << " = "
          << (unsigned int)add_sub->out << ", "
          << (unsigned int)add_sub->cout << " : "
          << result_text;

      log_to_file(result_text, waited_results, max_int);

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

      test_error |= error;
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
       << (unsigned int)add_sub->a
       << ", operandB="
       << (unsigned int)add_sub->b
       << ", cin="
       << (unsigned int)add_sub->cin
       << ", sub="
       << (unsigned int)add_sub->sub
       << ", out="
       << (unsigned int)add_sub->out
       << ", cout="
       << (unsigned int)add_sub->cout
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

  ~ADD_SUB_TEST(void)
  {
    delete add_sub;
    add_sub = NULL;
    log_file_stream.close();
#ifdef VCD_TRACE_ON
    close_trace();
#endif
  }
};
#endif /* __COSIM_ADD_SUB_TEMPLATE_H__ */
