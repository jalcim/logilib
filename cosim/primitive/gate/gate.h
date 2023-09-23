#include <fcntl.h>
#include <unistd.h>
#include <typeinfo>
#include <iostream>
#include "../../tools/logs.h"
#include "verilated.h"

using namespace std;

#define E1 in & 1

#define E2 in & 2

#define X_GATES                                              \
  /* (output & 1) verilator fix verilog buffer management */ \
  X(_buf, ((E1) != (out & 1)))                               \
  X(_not, ((E1) == out))                                     \
  X(_and, ((E1) & ((E2) >> 1)) != out)                       \
  X(_nand, ((E1) & ((E2) >> 1)) == out)                      \
  X(_or, ((E1) | ((E2) >> 1)) != out)                        \
  X(_nor, ((E1) | ((E2) >> 1)) == out)                       \
  X(_xor, ((E1) ^ ((E2) >> 1)) != out)                       \
  X(_xnor, ((E1) ^ ((E2) >> 1)) == out)

extern VerilatedContext *contextp;

bool run_gates_tests();

const string LOG_PATH_PREFIX = "build/cosim/primitive/gate/gate";
const string LOG_PATH_SUFFIX = "_check";

template <class VGATE>
class GATE_TEST
{

  int error;
  int log_fd;
  string log_path;
  const char *name;
  VGATE *gate;

public:
  GATE_TEST(void)
  {
    gate = new VGATE{contextp};
    name = typeid(gate).name();
    log_path = LOG_PATH_PREFIX + name + LOG_PATH_SUFFIX;
    log_fd = open(log_path.c_str(), O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
  }

  bool test(bool (*test_fn)(int input, int output))
  {
    bool error = false;
    int input = 0;
    bool gate_error;

    cout << "\n\n# Test " << name << " : " << endl;

    while (input < 4)
    {
      gate->in = input;
      gate->eval();

      gate_error = test_fn(gate->in, gate->out);
      log(gate_error);

      error |= gate_error;

      if (gate_error)
      {
        log_error();
      }

      input++;
    }

    cout << "Test " << (RESTEXT(error));

    return (error);
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
  //   gate->eval();

  //   // Falling edge
  //   gate->i_clk = 0;
  //   gate->eval();
  // }
  int log(bool error)
  {
    return dprintf(log_fd, "E1=%d, E2=%d, out=%d | test %s : %s\n", gate->E1, gate->E2 >> 1, gate->out, name, RESTEXT(error));
  }

  void log_error()
  {
    cerr << "\nLogs in : " << log_path << endl
         << "\n\n"
         << name << " : \n";

    debug_input_error(3, "Wire 0", get_bit(gate->in, 0), "Wire 1", get_bit(gate->in, 1), "Output", gate->out);
  }

  bool done(void) { return (Verilated::gotFinish()); }

  ~GATE_TEST(void)
  {
    delete gate;
    gate = NULL;
    close(log_fd);
  }
};
