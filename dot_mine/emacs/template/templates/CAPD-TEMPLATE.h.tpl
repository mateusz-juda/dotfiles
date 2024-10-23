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

#ifndef (>>>CAPD-FILE-GUARD<<<)_H
#define (>>>CAPD-FILE-GUARD<<<)_H

// #include
#include <capd/auxil/Logger.h>

namespace capd
{
  namespace (>>>CAPD-MODULE<<<)
  {

    template<typename >
    class (>>>CAPD-CLASS<<<)
    {

    public:
      (>>>CAPD-CLASS<<<)() {}

      void operator()();

      virtual ~(>>>CAPD-CLASS<<<)() {}

    private:
      (>>>CAPD-CLASS<<<)(const (>>>CAPD-CLASS<<<)&);
      (>>>CAPD-CLASS<<<)& operator=(const (>>>CAPD-CLASS<<<)&);

      CAPD_CLASS_LOGGER;
    };
    (>>>POINT<<<)

    template<typename >
    auto
    Call(>>>CAPD-CLASS<<<)()
    {
      (>>>CAPD-CLASS<<<) obj;
      return obj();
    }

  }
}

#endif // (>>>CAPD-FILE-GUARD<<<)_H
