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

#ifndef (>>>MJ-CPP-FILE-GUARD<<<)_H
#define (>>>MJ-CPP-FILE-GUARD<<<)_H

// #include
#include "capd_cts/cts_helpers/logger.h"

namespace (>>>MJ-CPP-PACKAGE<<<)::(>>>MJ-CPP-MODULE<<<)
{
    template<typename >
    class (>>>MJ-CPP-CLASS<<<)
    {

    public:
      explicit (>>>MJ-CPP-CLASS<<<)() {}
      (>>>MJ-CPP-CLASS<<<)(const (>>>MJ-CPP-CLASS<<<)&)=delete;
      (>>>MJ-CPP-CLASS<<<)((>>>MJ-CPP-CLASS<<<)&&)=default;      
      virtual ~(>>>MJ-CPP-CLASS<<<)() {}

      (>>>MJ-CPP-CLASS<<<)& operator=(const (>>>MJ-CPP-CLASS<<<)&)=delete;
      (>>>MJ-CPP-CLASS<<<)& operator=((>>>MJ-CPP-CLASS<<<)&&)=default;      
      
    private:
      CAPD_CTS_CLASS_LOGGER
    };
    (>>>POINT<<<)

}

#endif // (>>>MJ-CPP-FILE-GUARD<<<)_H
