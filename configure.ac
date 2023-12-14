## Process this file with autoconf to produce a configure script.
m4_include([inst/m4/m4_ax_lib_gdal.m4])


# The version set here will propagate to other files from here
AC_INIT([gdalBindings],[0.0.1])

# Checks for common programs using default macros
CC=`"${R_HOME}/bin/R" CMD config CC`
CFLAGS=`"${R_HOME}/bin/R" CMD config CFLAGS`
CPPFLAGS=`"${R_HOME}/bin/R" CMD config CPPFLAGS`
LDFLAGS=`"${R_HOME}/bin/R" CMD config LDFLAGS`
AC_PROG_CC  


#################
## GDAL
#################
AX_LIB_GDAL2()


##################
## END
##################


AC_CONFIG_FILES([src/Makevars])
AC_OUTPUT

