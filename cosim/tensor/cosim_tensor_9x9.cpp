#include <stdio.h>
#include <boost/test/unit_test.hpp>
#include <Vsynth_9x9.h>
#include <Vsynth_28x28.h>
#include "verilated_vcd_c.h"

#include <print>

BOOST_AUTO_TEST_SUITE (Vtensor_9x9_tests)

BOOST_AUTO_TEST_CASE (test_tensor_9x9)
{
  VerilatedContext *contextp = new VerilatedContext;
  contextp->traceEverOn(true);

  Vsynth_9x9 *tensor = new Vsynth_9x9{contextp};

  VerilatedVcdC *tfp = new VerilatedVcdC;
  tensor->trace(tfp, 99);
  tfp->open("tensor_9x9.vcd");

  int i = -1;
  while (++i < 81)
    {
      ((uint32_t*)&tensor->img)[i] = i;
      std::print("img[{}] = {}\n", i, i);
    }

  std::print("\n\n\n");

  ((uint32_t*)&tensor->kernel)[0] = 0;
  ((uint32_t*)&tensor->kernel)[1] = 1;
  ((uint32_t*)&tensor->kernel)[2] = 2;
  ((uint32_t*)&tensor->kernel)[3] = 3;
  ((uint32_t*)&tensor->kernel)[4] = 4;
  ((uint32_t*)&tensor->kernel)[5] = 5;
  ((uint32_t*)&tensor->kernel)[6] = 6;
  ((uint32_t*)&tensor->kernel)[7] = 7;
  ((uint32_t*)&tensor->kernel)[8] = 8;

  contextp->timeInc(1);
  tfp->dump(contextp->time());

  tensor->eval();

  contextp->timeInc(1);
  tfp->dump(contextp->time());

  uint32_t result[81] = {};

  int cpt = -1;
  while (++cpt <= 80)
    {
      result[cpt] = ((uint32_t*)&tensor->result)[cpt];
      std::print("result[{}] = {}\n", cpt, result[cpt]);
    }

  tfp->close();
  delete tfp;
  delete tensor;
  delete contextp;
}

BOOST_AUTO_TEST_SUITE_END()
