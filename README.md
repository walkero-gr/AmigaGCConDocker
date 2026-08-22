[![Codacy Badge](https://app.codacy.com/project/badge/Grade/a2a863e7754e46c7bafaed8e47e8e41a)](https://www.codacy.com/gh/walkero-gr/AmigaGCConDocker/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=walkero-gr/AmigaGCConDocker&amp;utm_campaign=Badge_Grade)
[![CodeFactor](https://www.codefactor.io/repository/github/walkero-gr/amigagccondocker/badge)](https://www.codefactor.io/repository/github/walkero-gr/amigagccondocker)
[![Docker Pulls](https://img.shields.io/docker/pulls/walkero/amigagccondocker?color=brightgreen)](https://hub.docker.com/r/walkero/amigagccondocker)

# AmigaGCConDocker

AmigaGCConDocker is a project with different Docker images that can be used as the base for a cross-compiling development environment for AmigaOS 4 (ppc-amigaos) and MorphOS (ppc-morphos). They are based on GCC versions 8, 9, 10, 11 and 13 and they are based on Ubuntu. They have installed everything needed (gcc compiler, SDKs, libraries) for compiling your applications out of the box.

The purpose of the project is to be an up-to-date, flexible and out-of-the-box solution for cross-compiling applications for Amiga OS4 or MorphOS, using the GCC C/C++ compiler. Those Docker images can be used on CI/CD solutions for automatic testing, compiling, packaging and deployment.

## Docker images

AmigaGCConDocker is split into different Docker images for better manipulation and updates. Those are separated by tags, which can be seen below, as well as their purpose.

There are **amd64** and **arm64** images, ready to be used on any system based on these cpu architectures.

Here is a list of the supported systems, with to links to necessary information.

| system    | information                            | versions                                 |
| --------- | -------------------------------------- | ---------------------------------------- |
| AmigaOS 4 | [ppc-amigaos](./docs/ppc-amigaos.md)   | [changelog](./ppc-amigaos/CHANGELOG.md)
| AmigaOS 3 | [m68k-amigaos](./docs/m68k-amigaos.md) | [changelog](./m68k-amigaos/CHANGELOG.md)
| MorphOS 3 | [ppc-morphos](./docs/ppc-morphos.md)   | [changelog](./ppc-morphos/CHANGELOG.md)

## How to use

Information about how to use these docker images can be found at [docs/docker.md](./docs/docker.md)

## Tools included

In the docker images there are different tools included. Read about them at [docs/tools.md](./docs/tools.md)

## Bug reports or feature request
If you have any issues with the images or you need help on using them or you would like to request any new feature, please contact me by opening an issue at https://github.com/walkero-gr/AmigaGCConDocker/issues
