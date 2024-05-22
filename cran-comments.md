## Fixes provided in this new submission

1. Use `gdal-config --dep-libs` only for MacOS as the `pkg-config` and 
   `gdal-config --libs` won't capture all the dependencies in MacOS platform.
2. Update windows and unix to use a simplified Makefile template file
