#include <Rcpp.h>
#include <ogr_srs_api.h>
#include <gdal_priv.h>
#include "gdal.h"
#include "proj.h"
using namespace Rcpp;


// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically
// run after the compilation.
//

//' @export
// [[Rcpp::export]]
Rcpp::LogicalVector CPL_set_data_dir(Rcpp::CharacterVector data_dir) {
    if (data_dir.size() != 1)
        Rcpp::stop("data_dir should be size 1 character vector"); // #nocov

    std::vector<const char*> cstrings{};
    for(const auto& string : data_dir)
        cstrings.push_back((Rcpp::as<std::string>(string)).c_str());
    
	OSRSetPROJSearchPaths(cstrings.data());
    
    Rcout << proj_context_get_database_path(PJ_DEFAULT_CTX);
	return true;
}
/*** R

*/
