# The version set here will propagate to other files from here
AC_INIT([gdalBindings],[0.1.20])

# Check pkg-config
PKG_PROG_PKG_CONFIG([0.15.0])

# Checks for common programs using default macros
#CC=`"${R_HOME}/bin/R" CMD config CC`
#CFLAGS=`"${R_HOME}/bin/R" CMD config CFLAGS`
#CPPFLAGS=`"${R_HOME}/bin/R" CMD config CPPFLAGS`
#LDFLAGS=`"${R_HOME}/bin/R" CMD config LDFLAGS`
AC_PROG_CC  


#################
## GDAL
#################
PKG_CHECK_MODULES(GDAL, gdal)


AC_CHECK_PROG(GDAL_CONFIG_CHECK,gdal-config,yes)
AS_IF([test x"$GDAL_CONFIG_CHECK" = x"yes"], [
  GDAL_DEP_LIBS=`gdal-config --dep-libs`
])

AC_SUBST([GDAL_DEP_LIBS])

##################
## END
##################

AC_CONFIG_FILES([src/Makevars])
AC_OUTPUT
