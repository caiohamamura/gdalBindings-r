OLD_PROJ <- Sys.getenv("PROJ_LIB")

.onUnload <- function(libpath) {
  library.dynam.unload("gdalBindings", libpath)
  Sys.setenv("PROJ_LIB" =  OLD_PROJ)
  invisible()
}

#' @useDynLib gdalBindings, .registration=TRUE
.onLoad <- function(libname, pkgname) {
  if (system.file("proj", package = pkgname)[1] != "") {
    Sys.setenv("PROJ_LIB" = system.file("proj", package = pkgname)[1])
  }
  Rcpp::loadModule("gdal_module", TRUE, TRUE)
  InitializeGDAL()
}