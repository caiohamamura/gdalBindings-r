## R CMD check results

0 errors | 0 warnings | 2 note

* This is a new release.

## Details on notes

The notes were:

1. Regarding being a new package and possible mispelled words GDAL and some references to classes. But as GDAL is actually only known by its acronym and since this package is intended mostly to developing other packages and functions it needs to address specific information from the classes and problems it solves for developing with GDAL.
2. Size of directories: since this is a compilation of GDAL, the PROJ database is needed and also the compiled code (in windows) will be more than 81 MB, since it is statically linked.

## Further information

This is a new package, but it is already being used by two other packages we are developing:
 
 - rGEDI: which were already published once in CRAN
 - rICESat2Veg: which is under developed and will soon be submitted.
 
 We decided to split `gdalBindings` into a different project instead of publishing each package with its own copy/compilation/binary, besides we find it can be useful for other developers working with Raster datasets.