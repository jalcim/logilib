#include <stdio.h>
#include <boost/test/unit_test.hpp>
#include "VDlatch_rst.h"
#include "Dlatch-utils.hpp"

static inline t_latch *dvalue(VDlatch_rst *dlatch, unsigned int D, unsigned int clk, unsigned int rst);

BOOST_AUTO_TEST_SUITE (VDlatch_rst_tests)

BOOST_AUTO_TEST_CASE (test_Dlatch)
{
  VerilatedContext *contextp = new VerilatedContext;

  VDlatch_rst *dlatch = new VDlatch_rst{contextp};
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

  latch = dvalue(dlatch, 0, 0, 1);
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

static inline t_latch *dvalue(VDlatch_rst *dlatch, unsigned int D, unsigned int clk, unsigned int rst)
{
  dlatch->D = D;
  dlatch->clk = clk;
  dlatch->rst = rst;
  dlatch->eval();

  return test_Dlatch_rst(D, clk, rst);
}
