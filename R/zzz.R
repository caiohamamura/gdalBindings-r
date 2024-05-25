.onUnload <- function(libpath) {
  library.dynam.unload("gdalBindings", libpath)
  invisible()
}

#' @useDynLib gdalBindings, .registration=TRUE
.onLoad <- function(libname, pkgname) {
  if (system.file("proj", package = pkgname)[1] != "") {
    proj_path <- system.file("proj", package = pkgname)[1]
  } else {
    proj_version <- GetProjVersion()
    
    # Since PROJ 9.1 the data files are stored in the PROJ_DATA instead of PROJ_LIB
    if (proj_version[1] > 9 || 
        (proj_version[1] == 9 && proj_version[2] >= 1)) {
      proj_path <- Sys.getenv("PROJ_DATA")
    } else {
      proj_path <- Sys.getenv("PROJ_LIB")
    }
  }
  Rcpp::loadModule("gdal_module", TRUE, TRUE)
  InitializeGDAL(proj_path)
}