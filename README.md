![Github](https://img.shields.io/badge/Github-0.1.17-green.svg)
![License](https://img.shields.io/badge/Licence-GPL--3-blue.svg) 
![Downloads](https://cranlogs.r-pkg.org/badges/grand-total/rgdalBindings)

**rgdalBindings: wraps around GDAL C library using Rcpp for reading and writing to Raster**

Authors: Caio Hamamura, Carlos Alberto Silva

The rgdalBindings package wraps around GDAL Raster and Band classes for reading
and writing directly from RasterBlock in R semantic `[[]]` and familiar syntax
for accessing RasterBand and reading/writing to blocks.

It also provides a `formulaCalculate()` function for allowing to perform
multiband calculations using formula, you only need to provide a named list
of RasterBands and the formula will evaluate against the provided names from
the list while updating the `updateBand` argument. It by reading the
RasterBlocks in an efficient way.

The package was developed mainly because the other solutions available don't 
work with the RasterBlock which is the most common way to read/save and operate
over raster datasets. This ensures you will be able to read/write data in small
chunks which fits in the memory and works with very efficient continuous file
pointers. 

This package allows you to access lower level GDAL dataset, so you can
efficiently implement your own algorithms and calculations for operating over
raster, without sacrificing too much performance. It also allows you to work
with extremely large datasets, by accessing only specific parts of it in an
efficient way and block by block.

# Using the package

## Installation
```r
#The CRAN version:
install.packages("rgdalBindings")

# The development version:
#install.packages("remotes")
remotes::install_github('caiohamamura/rgdalBindings')
```


## Creating a new raster dataset
```r
raster_path <- file.path(tempdir(), "output.tif")

ul_lat <- -15
ul_lon <- -45
lr_lat <- -25
lr_lon <- -35

res <- c(0.01, -0.01)
datatype <- gdalBindings::GDALDataType$GDT_Int32
nbands <- 2
projstring <- "EPSG:4326"
nodata <- -1
co <- c("TILED=YES", "BLOCKXSIZE=512", "BLOCKYSIZE=512", "COMPRESSION=LZW")

# Create a new raster dataset
ds <- createDataset(
  raster_path = raster_path,
  nbands = nbands,
  datatype = datatype,
  projstring = projstring,
  lr_lat = lr_lat,
  ul_lat = ul_lat,
  ul_lon = ul_lon,
  lr_lon = lr_lon,
  res = res,
  nodata = nodata,
  co = co
)
```

## Opening an existing dataset

```r
# For read only
raster <- GDALOpen("path/for/file.tif")

# For read and write
rasterWritable <- GDALOpen("path/for/file.tif", readonly = FALSE)

```

## Getting information

Currently the GDALDataset only have `GetRasterXSize()` and `GetRasterYSize()`
for retrieving information.

```r
# Get raster dimensions
width <- ds$GetRasterXSize()
height <- ds$GetRasterYSize()
```

## Accessing bands, reading and writing

The functions for accessing bands, reading and writing blocks are 
very R-like friendly to R users, you only need to index it with double
brackets `[[]]` as you are already used to.

Before reading and writing the pixels values you need to first choose a
band from for the dataset (1-index based):

```r
# Get the band 1 from ds
band <- ds[[1]]
```

Now you can read the blocks from the band retrieved using the indexing `[[]]`
operator, you can both write or read data as you are used to with other types
of data.

```r
# Set some dummy values
band[[0, 0]] <- 1:(512 * 512)

# Read the beggining of the block
head(band[[0, 0]])

#
# [1] 1 2 3 4 5 6
#
```

Note that both writing and reading works with 1-D vector, that is the way GDAL
operates, and it is kept that way for performance reasons withing this package.


## Accessing band information

Band has additional information on how the data is stored with the functions:

1. `GetBlockXSize` and `GetBlockYSize`: so you can see how large tiles were
saved.
2. `GetNoDataValue`: to know what value is considered nodata within the raster.
3. `GetRasterDataType`: information on which type of number (byte, integer,
float, etc.).

```r
# Get the data type for the raster
datatype <- ds$GetRasterDataType()
```

## Raster algebra with `gdalBindings`

Raster algebra operations is done using the function `formulaCalculate`. It
accepts three parameters:

1. `formula`: a character formula, in which you can use any legal operations
within R formula's notation. 
2. `data`: a list of named bands, the names given within the list will be used
when evaluating the formula.
3. `updateBand`: the band where the result will be written on


```r
# Update band 2
updateBand = ds[[2]]

# Calculate double - 10, we will call the band "x" by naming the list index
formulaCalculate(
  formula = "x * 2 - 10",
  data = list(x = band),
  updateBand = updateBand
)
```

You could use as well bands from different datasets in the `data` parameter,
just make sure they are all opened and then don't forget to close them in the
end.

## Close the dataset after finishing to ensure data is saved and the file is unlocked

```r
ds$Close()
```

# Reporting Issues 
Please report any issue regarding the gdalBindings package to Dr. Hamamura (hamamura.caio@ifsp.edu.br)

# Citing rgdalBindings
Hamamura, C. rgdalBindings: wraps around GDAL C library using Rcpp for reading and writing to Raster, version 0.1.17, accessed on December. 14 2023, available at: <https://github.com/caiohamamura/gdalBindings-R>

