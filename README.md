![](https://github.com/caiohamamaura/rgdalBindings/blob/master/readme/cover.png)<br/>

[![R-CMD-check](https://github.com/caiohamamaura/rgdalBindings/actions/workflows/r.yml/badge.svg?branch=master)](https://github.com/caiohamamaura/rgdalBindings/actions/workflows/r.yml)
[![CRAN](https://www.r-pkg.org/badges/version/rgdalBindings)](https://cran.r-project.org/package=rgdalBindings)
![Github](https://img.shields.io/badge/Github-0.1.12-green.svg)
![licence](https://img.shields.io/badge/Licence-GPL--3-blue.svg) 
![Downloads](https://cranlogs.r-pkg.org/badges/grand-total/rgdalBindings)
[![Build Status](https://travis-ci.com/caiohamamaura/rgdalBindings.svg?token=Jqizwyc6gBxNafNccTdU&branch=master)](https://travis-ci.com/caiohamamaura/rgdalBindings)

**rgdalBindings: wraps around GDAL C library using Rcpp for reading and writing to Raster**

Author: Caio Hamamura  

The rgdalBindings package wraps around GDAL Raster and Band classes for reading and writing
directly from RasterBlock in R semantic `[[]]` and familiar syntax
for accessing RasterBand and reading/writing to blocks.

It also provides a `formulaCalculate()` function for allowing to perform multiband calculations
using formula, you only need to provide a named list of RasterBands and the formula will evaluate
against the provided names from the list while updating the `updateBand` argument. It by reading
the RasterBlocks in an efficient way.

# Getting Started

## Installation
```r
#The CRAN version:
install.packages("rgdalBindings")

# The development version:
#install.packages("remotes")
remotes::install_github('caiohamamura/rgdalBindings')
```

# Reporting Issues 
Please report any issue regarding the gdalBindings package to Dr. Hamamura (hamamura.caio@ifsp.edu.br)

# Citing rgdalBindings
Hamamura, C. rgdalBindings: wraps around GDAL C library using Rcpp for reading and writing to Raster, version 0.1.1, accessed on December. 13 2023, available at: <https://CRAN.R-project.org/package=gdalBindings>

