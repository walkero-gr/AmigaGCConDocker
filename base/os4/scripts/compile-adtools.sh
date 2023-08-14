#!/usr/bin/bash

git config --global user.email "walkero@gmail.com"
git config --global user.name "Georgios Sokianos"
git submodule init && \
	git submodule update && \
	gild/bin/gild checkout binutils 2.23.2 && \
	gild/bin/gild checkout gcc $GCC_VER && \
	\cp /opt/misc/texi2pod.pl /opt/adtools/binutils/repo/etc/

if [ X"$CLIB2_REPO" = X"afxgroup" ]; then
	echo "-------- AFXGROUP IS USED"

	# Install clib2 and libraries from afxgroup's Ubuntu repo. 
	# They are saved under /user/ppc-amigaos
	curl -fsSL https://clib2pkg.amigasoft.net/ubuntu/clib2.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/clib2.gpg && \
		echo "deb https://clib2pkg.amigasoft.net/ubuntu/ focal main" | tee /etc/apt/sources.list.d/clib2.list && \
		apt-get update && apt-get -y --no-install-recommends install amigaos4-clib2

	echo "-------- amigaos4-clib2 INSTALLED"
	# These files are necessary so that shared libraries work with afxgroup's clib2
	# and math duplication issues to be solved
	\cp /opt/misc/clib2-afxgroup/amigaos.h /opt/adtools/gcc/repo/gcc/config/rs6000/ && \
		\cp /opt/misc/clib2-afxgroup/configure /opt/adtools/gcc/repo/libstdc++-v3/

	echo "-------- PATCHES COPIED"
fi;

# Compile gcc
echo "-------- START GCC COMPILATION"
make -C native-build gcc-cross CROSS_PREFIX=/opt/ppc-amigaos CLIB2_REPO=$CLIB2_REPO CLIB2_SRC=$CLIB2_SRC -j$(nproc)
