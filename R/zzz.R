.onUnload <- function(libpath) {
  library.dynam.unload("gdalBindings", libpath)
  invisible()
}

#' @useDynLib gdalBindings, .registration=TRUE
.onLoad <- function(libname, pkgname) {
  Rcpp::loadModule("gdal_module", TRUE, TRUE)
  proj_path <- ""
  proj_version <- GetProjVersion()

  major <- proj_version[1]
  minor <- proj_version[2]

  # Since PROJ 9.1, the data files are in PROJ_DATA instead of PROJ_LIB
  if (major > 9 ||
    (major == 9 && minor >= 1)) {
    proj_path <- Sys.getenv("PROJ_DATA")
  } else {
    proj_path <- Sys.getenv("PROJ_LIB")
  }

  if (proj_path == "") {
    proj_path <- system.file("proj", package = pkgname)[1]
  }

  InitializeGDAL(proj_path)
}
