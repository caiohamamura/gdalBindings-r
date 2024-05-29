## Fixes provided in this new submission

Uwe Ligges has asked us to use `gdal-config --libs` only during the configuration
step, and only add `gdal-config --dep-libs` if that failed as it is done
in `sf` package. 

The problem is that this will still not account for every type of system either,
as in windows using `gdal-config --libs` is not sufficient for a successful
compilation for instance.

In this package the configure step including `configure.win` is also derived
from the same `configure.ac`, using a single base `Makevars.in` for every
platform ensuring more maintainability as there is only one single source of
`configure.ac` for handling that, instead of handling multiple `Makevars` variants.

The configuration script also makes use of functions that reuses the same logic
for multiple ran tests, ensuring consistency and maintainability as we handle
repetitive code only once. 

Those improvements makes these scripts much more succint and readable, also
making use of autotools best practices as usage of their native macros
such as AS_IF, AC_PATH_PROG, AC_LINK_IFELSE, PKG_CHECK_MODULES, which ensures
cross platform compatibility.
