# Initialize the package and version
AC_INIT([gdalBindings], [0.1.20])

# Check for the required version of pkg-config
PKG_PROG_PKG_CONFIG([0.15.0])

# Check for the presence of a C compiler
AC_PROG_CC  

# Get the system type
host_os=`"$R_HOME/bin/Rscript" -e "suppressWarnings(Sys.info()[['sysname']])"`
AC_MSG_NOTICE([Detected OS: $host_os])

#################
## GDAL
#################
# Check for GDAL using pkg-config
PKG_CHECK_MODULES([GDAL], [gdal])

#--------------------------------
#- macOS Specific GDAL deps (won't compile otherwise)
#--------------------------------
# Execute only if the host OS is macOS
case "$host_os" in
  *Darwin*)
    # Commands or configurations specific to macOS
    AC_MSG_NOTICE([Configuring for macOS])
    # Check if gdal-config is available
    AC_CHECK_PROG([GDAL_CONFIG_CHECK], [gdal-config], [yes])
    AS_IF([test x"$GDAL_CONFIG_CHECK" = x"yes"], [
      GDAL_DEP_LIBS=`gdal-config --dep-libs`
    ])
    ;;
esac

AC_SUBST([GDAL_DEP_LIBS])

################
## PROJ
################
PKG_CHECK_MODULES([PROJ], [proj])

##################
## END
##################

# Configure the output files
AC_CONFIG_FILES([src/Makevars])
AC_OUTPUT