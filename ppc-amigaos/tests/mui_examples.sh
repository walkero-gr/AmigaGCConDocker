#!/usr/bin/bash
# 

cd $SDK_PATH/Examples/MUI
ppc-amigaos-gcc -o title Title.c -D__USE_INLINE__ -lauto
ppc-amigaos-gcc -o Virtual Virtual.c -D__USE_INLINE__ -lauto
ppc-amigaos-gcc -o WbMan WbMan.c -D__USE_INLINE__ -lauto