## Fixes provided in this new submission

1. Now the configure script will try to compile and link
  - First using only pkg-config
  - As a fallback it will try to use gdal-config --dep-libs
  - Add sanity check to make sure proj.db can be loaded during configure step
  - Always copy PROJ data from `pkg-config --variable=datadir proj` and use that
  to ensure the same PROJ used during compilation of $SHLIB is used within the package
