#include <stdio.h>
#include <boost/test/unit_test.hpp>
#include "VDlatch.h"
#include "Dlatch-utils.hpp"

t_latch *dvalue(VDlatch *dlatch, unsigned int D, unsigned int clk);

BOOST_AUTO_TEST_SUITE (VDlatch_tests)

BOOST_AUTO_TEST_CASE (test_Dlatch)
{
  VerilatedContext *contextp = new VerilatedContext;

  VDlatch *dlatch = new VDlatch{contextp};
  t_latch *latch;

  latch = dvalue(dlatch, 0, 1);
  BOOST_REQUIRE_EQUAL(dlatch->Q, latch->Q);

  latch = dvalue(dlatch, 0, 0);
  BOOST_REQUIRE_EQUAL(dlatch->Q, latch->Q);

  latch = dvalue(dlatch, 1, 0);
  BOOST_REQUIRE_EQUAL(dlatch->Q, latch->Q);

  latch = dvalue(dlatch, 1, 1);
  BOOST_REQUIRE_EQUAL(dlatch->Q, latch->Q);

  latch = dvalue(dlatch, 1, 0);
  BOOST_REQUIRE_EQUAL(dlatch->Q, latch->Q);

  latch = dvalue(dlatch, 0, 1);
  BOOST_REQUIRE_EQUAL(dlatch->Q, latch->Q);

  latch = dvalue(dlatch, 0, 0);
  BOOST_REQUIRE_EQUAL(dlatch->Q, latch->Q);

  delete latch;
  delete dlatch;
  delete contextp;
}

BOOST_AUTO_TEST_SUITE_END()

t_latch *dvalue(VDlatch *dlatch, unsigned int D, unsigned int clk)
{
  dlatch->D = D;
  dlatch->clk = clk;
  dlatch->eval();

  return test_Dlatch(D, clk);
}
