#!/usr/bin/bash

git config --global user.email "walkero@gmail.com"
git config --global user.name "Georgios Sokianos"
git submodule init && \
	git submodule update && \
	gild/bin/gild checkout binutils 2.23.2 && \
	gild/bin/gild checkout gcc $GCC_VER

# Compile gcc
echo "-------- START GCC COMPILATION"
make -C native-build gcc-cross CROSS_PREFIX=/opt/ppc-amigaos CLIB4_SHA1=beta10 -j$(nproc)
