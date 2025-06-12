#include <stdio.h>
#include <boost/test/unit_test.hpp>
#include "bru-utils.hpp"
#include "Vbru.h"

BOOST_AUTO_TEST_SUITE (Vbru_tests)

BOOST_AUTO_TEST_CASE (validator_bru)
{
    int result;

    Vbru *bru = new Vbru();

    bru->in = 0;
    bru->funct3 = 0;
    bru->SIGNAL_bru = 0;
    bru->eval();

    size_t input = 0;
    unsigned int funct3 = 0;
    unsigned int signal_bru = 0;
    result = test_bru(input, funct3 & 7, signal_bru & 1) & 1;
    if (bru->SIGNAL_pc != result)
      printf("bru input = %x, funct3 = %x, signal_bru = %x : signal_pc = %x, result = %x\n",
	     input, funct3 & 7, signal_bru & 1, bru->SIGNAL_pc & 1, result);
    BOOST_REQUIRE_EQUAL(bru->SIGNAL_pc & 1, result);
    delete bru;
}

BOOST_AUTO_TEST_SUITE_END()
