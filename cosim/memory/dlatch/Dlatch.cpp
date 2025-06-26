#include <stdio.h>
#include <boost/test/unit_test.hpp>
#include "VDlatch.h"

BOOST_AUTO_TEST_SUITE (VDlatch_tests)

BOOST_AUTO_TEST_CASE (test_Dlatch)
{
  VerilatedContext *contextp;

  VDlatch *dlatch = new VDlatch{contextp};

  dlatch->D = 0;
  dlatch->clk = 0;
  dlatch->eval();

  BOOST_REQUIRE_EQUAL(dlatch->Q, 0);
}

BOOST_AUTO_TEST_SUITE_END()
