#include <stdio.h>
#include <boost/test/unit_test.hpp>
#include "VDlatch_pre.h"
#include "Dlatch-utils.hpp"

static inline t_latch *dvalue(VDlatch_pre *dlatch, unsigned int D, unsigned int clk, unsigned int pre);

BOOST_AUTO_TEST_SUITE (VDlatch_pre_tests)

BOOST_AUTO_TEST_CASE (test_Dlatch)
{
  VerilatedContext *contextp = new VerilatedContext;

  VDlatch_pre *dlatch = new VDlatch_pre{contextp};
  t_latch *latch;

  latch = dvalue(dlatch, 0, 0, 1);
  BOOST_REQUIRE_EQUAL(dlatch->Q, latch->Q);

  latch = dvalue(dlatch, 0, 1, 0);
  BOOST_REQUIRE_EQUAL(dlatch->Q, latch->Q);

  latch = dvalue(dlatch, 1, 0, 0);
  BOOST_REQUIRE_EQUAL(dlatch->Q, latch->Q);

  latch = dvalue(dlatch, 1, 1, 0);
  BOOST_REQUIRE_EQUAL(dlatch->Q, latch->Q);

  latch = dvalue(dlatch, 1, 0, 0);
  BOOST_REQUIRE_EQUAL(dlatch->Q, latch->Q);

  latch = dvalue(dlatch, 0, 1, 0);
  BOOST_REQUIRE_EQUAL(dlatch->Q, latch->Q);

  latch = dvalue(dlatch, 0, 0, 0);
  BOOST_REQUIRE_EQUAL(dlatch->Q, latch->Q);

  delete latch;
  delete dlatch;
  delete contextp;
}

BOOST_AUTO_TEST_SUITE_END()

static inline t_latch *dvalue(VDlatch_pre *dlatch, unsigned int D, unsigned int clk, unsigned int pre)
{
  dlatch->D = D;
  dlatch->clk = clk;
  dlatch->pre = pre;
  dlatch->eval();

  return test_Dlatch_pre(D, clk, pre);
}
