# AmigaOS 4 (ppc-amigaos)

## Available tags:

All the available docker images' tags can be seen at [Docker hub](https://hub.docker.com/r/walkero/amigagccondocker/tags)

- GCC 6: `os4-gcc6`
- GCC 8: `os4-gcc8`
- GCC 9: `ppc-amigaos-gcc9`
- GCC 10: `ppc-amigaos-gcc10`
- GCC 11: `os4-gcc11`
- GCC 13: `os4-gcc13`

The docker images with gcc versions 6,11,13 support newlib, clib2 and clib4 and they are the most updated releases.

The gcc v6 supports SPE CPU's and can be used to optimize code for systems like the A1222.

## GCC versions supported

| docker image | version |
| ------------ | ------- |
| gcc6         | 6.4.0   |
| gcc8         | 8.4.0   |
| gcc9         | 9.1.0   |
| gcc10        | 10.3.0  |
| gcc11        | 11.5.0  |
| gcc13        | 13.4.0  |

## Included SDKs

| SDK           | version      | source                                       |
| ------------- | ------------ | -------------------------------------------- |
| AmigaOS 4 SDK | 54.25        | http://www.hyperion-entertainment.com/       |
| MUI 5.x dev   | 5.0-20210831 | http://muidev.de/downloads                   |
| AmiSSL SDK    | 5.27         | https://github.com/jens-maus/amissl/releases |

The list above is not complete and a lot more are included. A full list can be seen at `ppc-amigaos/scripts/libs/` folder in this repo. There are different bash scripts for each library that describe where they are downloaded from and how they are installed. All of them are installed under SDK path `/opt/ppc-amigaos/ppc-amigaos/SDK/local`.
