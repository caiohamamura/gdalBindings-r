# h/t to @jimhester and @yihui for this parse block:
# https://github.com/yihui/knitr/blob/dc5ead7bcfc0ebd2789fe99c527c7d91afb3de4a/Makefile#L1-L4
# Note the portability change as suggested in the manual:
# https://cran.r-project.org/doc/manuals/r-release/R-exts.html#Writing-portable-packages
PKGNAME = `sed -n "s/Package: *\([^ ]*\)/\1/p" DESCRIPTION`
PKGVERS = `sed -n "s/Version: *\([^ ]*\)/\1/p" DESCRIPTION`


all: check

preprocess:
	autoreconf
	autoconf --output=configure.win configure.ac
	./cleanup

check:
	Rscript -e "devtools::check()"

install_deps:
	Rscript \
	-e 'if (!requireNamespace("remotes")) install.packages("remotes")' \
	-e 'remotes::install_deps(dependencies = TRUE)'

install:
	Rscript -e "devtools::install()"

check_rhub:
	Rscript -e "rhub::rhub_check(platforms = c('windows', 'linux', 'macos'))"

build:
	./cleanup
	R CMD build .
