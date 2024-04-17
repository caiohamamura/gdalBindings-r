.onUnload <- function(libpath) {
  library.dynam.unload("gdalBindings", libpath)
  invisible()
}

#' @useDynLib gdalBindings, .registration=TRUE
.onLoad <- function(libname, pkgname) {
  Rcpp::loadModule("gdal_module", TRUE, TRUE)
  InitializeGDAL()
}

.onAttach <- function(libname, pkgname) {
  if (Sys.getenv("PROJ_LIB") == "") {
    Sys.setenv("PROJ_LIB" = system.file("proj", package = pkgname)[1])
  }
  if (Sys.getenv("GDAL_DATA") == "") {
    Sys.setenv("GDAL_DATA" = system.file("gdal", package = pkgname)[1])
  }
}
