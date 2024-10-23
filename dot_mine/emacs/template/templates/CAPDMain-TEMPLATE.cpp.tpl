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

#include <capd/auxil/ApplicationDesc.h>
#include <capd/auxil/Logger.h>

#include <boost/program_options.hpp>

#include <string>
#include <iostream>

using namespace capd;

namespace {
const capd::auxil::ApplicationDesc applicationDesc("(>>>CAPD-PACKAGE<<<)::(>>>CAPD-MODULE<<<)::(>>>FILE_SANS<<<)",
                                                   "Mateusz Juda <mateusz.juda@{ii.uj.edu.pl,gmail.com}>",
                                                   "(>>>ISO_DATE<<<)", "");
}

int main(int argc, char* argv[])
{
   try {
      INIT_CAPD_LOGGER;
      CAPD_INFO("Entering application:\n" << applicationDesc);

      namespace po = boost::program_options;

      po::options_description desc("Allowed options");
      po::positional_options_description positionalDesc;

      desc.add_options()("help,h", "produce help message");

      // std::vector<std::string> filenames;
      // std::string outputFilename;

      // desc.add_options()
      //   ("files,f", po::value<std::vector<std::string> >(&filenames)->multitoken(), "list of files")
      //   ("output,o", po::value<std::string>(&outputFilename)->required(), "output");

      // positionalDesc.add(key, 1);
      // desc.add_options()(key, po::value<std::string>(&positional), "positional");

      po::variables_map vm;
      po::store(po::command_line_parser(argc, argv).options(desc).positional(positionalDesc).run(), vm);
      po::notify(vm);

      if (vm.count("help") > 0) {
         std::cout << desc << std::endl;
         return 0;
      }

      return 0;
   }
   catch (std::exception& ex) {
      std::cerr << "Error: " << ex.what() << std::endl;
      return 1;
   }
   catch (const char* ex) {
      std::cerr << "Error: " << ex << std::endl;
      return 1;
   }
   catch (const std::string& ex) {
      std::cerr << "Error: " << ex << std::endl;
      return 1;
   }
   catch (...) {
      std::cerr << "Unknown exception" << std::endl;
      return 1;
   }

   return 1;
}
