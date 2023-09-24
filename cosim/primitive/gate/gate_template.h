#ifndef __COSIM_GATE_TEMPLATE_H__
#define __COSIM_GATE_TEMPLATE_H__
#include <fcntl.h>
#include <unistd.h>
#include <typeinfo>
#include <iostream>
#include <cmath>
#include "../../tools/logs.h"
#include "verilated.h"
#include "gate_macros.h"

using namespace std;

extern VerilatedContext *contextp;

const string LOG_PATH_PREFIX = "build/cosim/primitive/gate/gate";
const string LOG_PATH_SUFFIX = "_check";

template <class VGATE>
class GATE_TEST
{

  int error;
  int log_fd;
  int way_number;
  string log_path;
  const char *name;
  VGATE *gate;
  int (*test_fn)(int input, int way);

public:
  GATE_TEST(int (*gate_test)(int input, int way), int ways)
  {
    gate = new VGATE{contextp};
    test_fn = gate_test;
    way_number = ways;
    name = typeid(gate).name();
    log_path = LOG_PATH_PREFIX + name + LOG_PATH_SUFFIX;
    log_fd = open(log_path.c_str(), O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
  }

  bool test()
  {
    const int input_max = pow(2, way_number);
    bool test_error = false;
    int input = 0;
    int waited_result;
    int result;
    bool error;

    cout << "\n\n# Test " << name << " : " << endl;
    while (input < input_max)
    {
      cout << "\nTest input " << input << " : " << endl;
      gate->in = input;
      gate->eval();
      waited_result = test_fn(gate->in, way_number) & 1;

      /* fix verilog buffer management */
      result = gate->out & 1;

      error = result != waited_result;
      log(error, waited_result);

      test_error |= error;

      cout << "\n"
           << (RESTEXT(error)) << endl;

      if (error)
      {
        log_error(error, waited_result);
      }

      input++;
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
  int log(bool test_error, int waited_result)
  {
    return dprintf(log_fd, "\nTest %s : %s |-> E1=%d, E2=%d,E3=%d,E4=%d,E5=%d,E6=%d,E7=%d, out=%d  waited_result %d \n", name, RESTEXT(test_error), GET_BIT(gate->in, 0), GET_BIT(gate->in, 1), GET_BIT(gate->in, 2), GET_BIT(gate->in, 3), GET_BIT(gate->in, 4), GET_BIT(gate->in, 5), GET_BIT(gate->in, 6), gate->out, waited_result);
  }

  void log_error(bool test_error, int waited_result)
  {
    dprintf(2, "\nTest %s : %s |-> E1=%d, E2=%d,E3=%d,E4=%d,E5=%d,E6=%d,E7=%d,out=%d  waited_result %d", name, RESTEXT(test_error), GET_BIT(gate->in, 0), GET_BIT(gate->in, 1), GET_BIT(gate->in, 2), GET_BIT(gate->in, 3), GET_BIT(gate->in, 4), GET_BIT(gate->in, 5), GET_BIT(gate->in, 6), gate->out, waited_result);

    cerr << "\nLogs in : " << log_path << endl;
  }

  bool done(void) { return (Verilated::gotFinish()); }

  ~GATE_TEST(void)
  {
    delete gate;
    gate = NULL;
    close(log_fd);
  }
};
#endif /* __COSIM_GATE_TEMPLATE_H__ */
