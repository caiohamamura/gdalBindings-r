## Fixes provided in this new submission

1. As requested by Uwe Ligges, we've updated the linking to libsharpyuv
to work with both Rtools43 and oldrelease Rtools42 using:

```
LIBSHARPYUV = $(or $(and $(wildcard $(R_TOOLS_SOFT)/lib/libsharpyuv.a),-lsharpyuv),) 
PKG_LIBS = ... -lwebp $(LIBSHARPYUV) ...
```.