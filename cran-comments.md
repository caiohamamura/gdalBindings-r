## Fixes provided in this new submission

1. As requested we updated the way proj.db is being linked: 
   - unix: default environment variable PROJ_LIB
   - windows: cp -r /x86_64-w64-mingw32.static.posix/share/proj ./inst/proj

2. Update ucrt and configure scripts to rely on pkg-config
