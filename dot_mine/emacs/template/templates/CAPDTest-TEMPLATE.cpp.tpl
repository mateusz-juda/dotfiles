/////////////////////////////////////////////////////////////////////////////
/// @file (>>>CAPD-FILE<<<)
///
/// @author Mateusz Juda <mateusz.juda@{ii.uj.edu.pl,gmail.com}>
///
/// @date (>>>ISO_DATE<<<)
/////////////////////////////////////////////////////////////////////////////
//
// Copyright (C) 2000-(>>>YEAR<<<) by the CAPD Group.
//
// This file constitutes a part of the CAPD library ((>>>CAPD-PACKAGE<<<)),
// distributed under the terms of the GNU General Public License.
// Consult http://capd.ii.uj.edu.pl and  http://redhom.ii.edu.pl/ for details.
/////////////////////////////////////////////////////////////////////////////


#include <TestTools.h>
#include <capd/(>>>CAPD-MODULE<<<)/(>>>CAPD-CLASS<<<).h>
#include <capd/auxil/Logger.h>
//#include "../apiRedHom/Fixtures.h"
//#include "Fixtures.h"

#define BOOST_TEST_DYN_LINK

#include <boost/test/unit_test.hpp>
#include <boost/test/test_case_template.hpp>


namespace capd
{
  namespace test
  {

  }
}

using namespace capd;
using namespace capd::test;
using namespace capd::(>>>CAPD-MODULE<<<);

BOOST_AUTO_TEST_SUITE((>>>CAPD-CLASS<<<)TestSuite)

BOOST_AUTO_TEST_CASE((>>>CAPD-CLASS<<<)_init)
{

}

BOOST_AUTO_TEST_CASE_TEMPLATE((>>>CAPD-CLASS<<<)_init2, Fixture, Fixtures)
{
  Fixture fixture;
  auto& complex = fixture.complex();
  auto x = Call(>>>CAPD-CLASS<<<)(complex);

  (>>>POINT<<<)
}

BOOST_AUTO_TEST_SUITE_END()
