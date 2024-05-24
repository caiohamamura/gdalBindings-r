# Initialize the package and version
AC_INIT([gdalBindings],[0.1.28])

# Initialize autoconfig
AC_PREREQ([2.71])

# Check for the required version of pkg-config
PKG_PROG_PKG_CONFIG([0.15.0])

# Pick R specific compiler and flags
CXX=`"${R_HOME}/bin/R" CMD config CXX`
CPPFLAGS=`"${R_HOME}/bin/R" CMD config CPPFLAGS`
CXXFLAGS=`"${R_HOME}/bin/R" CMD config CXXFLAGS`

AC_MSG_CHECKING([the operating system name])
os_name=`"${R_HOME}/bin/Rscript" -e "cat(Sys.info()[['sysname']])"`
AC_MSG_RESULT([$os_name])

# Check for the presence of a C compiler
AC_PROG_CXX()


#################
## GDAL
#################
# Check for GDAL using pkg-config
PKG_CHECK_MODULES([GDAL], [gdal])

# Define CXXFLAGS which are used by default to compile the test program
CXXFLAGS="${CXXFLAGS} ${GDAL_CFLAGS}"

# Define CPPFLAGS which are used by default by AC_CHECK_HEADER
CPPFLAGS="${CPPFLAGS} ${GDAL_CFLAGS}" 

# Check if header files are present
AC_CHECK_HEADER([gdal.h],
  [],
  [
    AC_MSG_ERROR([gdal.h not found in given locations.])
  ]
)

# Define a macro to test if gdal test program compiles
AC_DEFUN([GDAL_TEST_PROGRAM_IFELSE], [
  AC_MSG_CHECKING([$1])
  AC_LANG_PUSH([C++])
  AC_LINK_IFELSE([
    AC_LANG_PROGRAM(
        [[#include <gdal.h>]],
        [[GDALAllRegister();]]
    )
  ]
  ,[
      AC_MSG_RESULT([yes])
      $2
    ], # Action if the program compiles correctly
    [
      AC_MSG_RESULT([no])
      $3
  ]   # Action if the program fails to compile
  )
  AC_LANG_POP([C++])
])

LIBS="${LIBS} ${GDAL_LIBS}"

GDAL_TEST_PROGRAM_IFELSE(
  [whether GDAL can be linked using only pkg-config],
  [
    gdal_can_compile=yes
    GDAL_DEP_LIBS=""
  ],
  [
    gdal_can_compile=no
  ]
)

AS_IF([test "x$gdal_can_compile" = "xno"],
  [
    AC_CHECK_PROG([GDAL_CONFIG_CHECK], [gdal-config], [yes])
    AS_IF(
      [test x"$GDAL_CONFIG_CHECK" = x"yes"], 
      [
        GDAL_DEP_LIBS=`gdal-config --dep-libs`
        LIBS="${LIBS} ${GDAL_DEP_LIBS}"
        
        GDAL_TEST_PROGRAM_IFELSE(
          [whether GDAL can be linked using gdal-config libs],
          [],
          [
            AC_MSG_ERROR([Could not link to GDAL neither with pkg-config only nor gdal-config.])
          ]
        )

      ],
      [
        AC_MSG_ERROR([gdal-config not found, is gdal installed?])
      ]
    )
  ]
)



AC_SUBST([GDAL_DEP_LIBS])

################
## PROJ
################
PKG_CHECK_MODULES([PROJ], [proj])

# Copy PROJ datadir
PKG_CHECK_VAR([PROJ_DATADIR], [proj], [datadir])

AC_MSG_CHECKING([proj datadir path])
AC_MSG_RESULT([$PROJ_DATADIR])

# Try to use the PROJ datadir
AC_MSG_CHECKING([whether PROJ can be ran using the datadir])

AC_LANG_PUSH([C++])
LIBS="${PROJ_LIBS}"
AC_RUN_IFELSE([
    AC_LANG_PROGRAM([[
        #include <proj.h>
    ]], [[
        const char* paths[] = {"$PROJ_DATADIR"};
        proj_context_set_search_paths(NULL, 1, paths);
        proj_create(NULL, "EPSG:4326");
        int ret = proj_context_errno(NULL);
        return ret;
    ]])
], [
    AC_MSG_RESULT([yes])
], [
    AC_MSG_ERROR([proj test program failed to run])
])
AC_LANG_POP([C++])

AC_SUBST([PROJ_DATADIR])

##################
## END
##################

# Configure the output files
output_files="src/Makevars"
AS_IF([test "x$os_name" = "xWindows"],
  [
    output_files="src/Makevars.ucrt"
    rm -f src/Makevars.ucrt.in
    cp src/Makevars.in src/Makevars.ucrt.in
  ]
)

AC_CONFIG_FILES([$output_files])
AC_OUTPUT