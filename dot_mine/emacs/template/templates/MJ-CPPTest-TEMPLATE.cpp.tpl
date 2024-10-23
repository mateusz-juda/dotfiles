/////////////////////////////////////////////////////////////////////////////
/// @file (>>>MJ-CPP-FILE<<<)
///
/// @author Mateusz Juda <mateusz.juda@{ii.uj.edu.pl,gmail.com}>
///
/// @date (>>>ISO_DATE<<<)
/////////////////////////////////////////////////////////////////////////////
//
// Copyright (C) 2000-(>>>YEAR<<<) by the CAPD Group.
//
// This file constitutes a part of the CAPD library ((>>>MJ-CPP-PACKAGE<<<)),
// distributed under the terms of the <MJ LICENSE> !!!!!!!!!
// Consult http://capd.ii.uj.edu.pl and  http://redhom.ii.edu.pl/ for details.
/////////////////////////////////////////////////////////////////////////////

#define BOOST_TEST_DYN_LINK

#include <(>>>MJ-CPP-PACKAGE<<<)/(>>>MJ-CPP-MODULE<<<)/(>>>MJ-CPP-FILE-BASENAME<<<).h>
#include "capd_cts/cts_helpers/logger.h"
#include <boost/test/unit_test.hpp>


namespace (>>>MJ-CPP-PACKAGE<<<)::test
{
   
}

using namespace (>>>MJ-CPP-PACKAGE<<<);
using namespace (>>>MJ-CPP-PACKAGE<<<)::test;
using namespace (>>>MJ-CPP-PACKAGE<<<)::(>>>MJ-CPP-MODULE<<<);
namespace utf = boost::unit_test;
namespace tt = boost::test_tools;

BOOST_AUTO_TEST_SUITE((>>>MJ-CPP-CLASS<<<)TestSuite)

BOOST_AUTO_TEST_CASE((>>>MJ-CPP-CLASS<<<)_init)
{

}

BOOST_AUTO_TEST_CASE_TEMPLATE((>>>MJ-CPP-CLASS<<<)_init2, Fixture, Fixtures)
{
  Fixture fixture;
  
  (>>>POINT<<<)
}

BOOST_AUTO_TEST_SUITE_END()
