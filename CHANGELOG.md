# Changelog
All notable changes to this project will be documented in this file.

## os4-2.7.0 - [2025-06-02]
### Added
- Added libopus 1.5.2
- Added libopusfile 0.12
- Added libopusenc 0.2.1
- Added libsdl2_gfx 1.0.4
- Added libsdl3_gfx 1.0.1
- Added libsdl3_image 3.2.4
- Added libsdl3_ttf 3.2.2
- Added the source-highlight library
- Added the unzip command

### Updated
- Updated libflac to 1.5.0
- Updated libmikmod to 3.3.13
- Updated libmodplug to 0.8.9.1
- Updated libsdl2_mixer to 2.8.1
- Updated SDL2 to 2.32.6
- Updated SDL3 to 3.2.14
- Updated libpng to 1.6.47

## os4-2.6.0 - [2025-05-09]
### Updated
- Updated clib4 to 1.6.0
- Updated AmiSSL to 3.20
- Updated SDL2 to 2.32.0
- Updated SDL3 to v3.2.8
- Updated libsdl2_image to 2.8.8 for newlib
- Updated libsdl2_ttf to 2.24.0 for newlib
- Updated librtmp to 2.6 for newlib
- Updated libsdl_ttf to 2.0.11.1 for newlib
- Updated many other libraries for newlib, clib2 and clib4

## os4-2.5.0 - [2025-02-15]
### Added
- Added a lot of clib4 third party libraries
- Added libharfbuzz 8.4.0 for newlib
- Added libsdl2_ttf 2.22.0 for newlib
- Added libyaml 0.2.5 for newlib, clib2 and clib4
- Added libzip 1.11.2 for newlib, clib2 and clib4
- Added liblz4 1.10.0 for newlib and clib4
- Added mandoc tool
- Added SDL3 v3.2 for newlib

### Updated
- Updated AmiSSL to 3.19
- Updated SDL2 to 2.30.9

### Fixed
- Fixed issue #10

## os4-2.4.0 - [2024-12-17]
### Added
- Added zip

### Changed
- Updated liblua to v5.4.7
- Updated pcre2 to version 10.44
- Using v1.4.0 of the base gcc images

### Removed
- removed the /local/clib4/include/GL because of inconsistencies

## 2.3.0 - [2024-11-26]
### Changed
- Updated clib4 to v1.4.0

## 2.2.0 - [2024-11-25]
### Added
- Added libregex 4.4.3
- Added librtmp 2.4 for newlib and clib2

### Changed
- Using v1.2.0 of the base images
- MUI SDK is now integrated with the SDK, using the default paths where
  the compiler expects to find the include files. Now, the MUI code should
  compile out of the box, without the need to set any path with a
  `-I` argument

## 2.1.2 - [2024-07-27]
### Added
- Added curl7-clib4
- Added openssl-quic-clib4
  
### Fixed
- Fixed a caching issue with the installation of clib4 libraries

## 2.1.1 - [2024-07-27]
### Added
- Added docker images for gcc 6 and 8

## 2.1.0 - [2024-07-25]
### Added
- Added the libsdl_ttf library
- Added the libft2 library

### Changed
- Updated the lua library to v5.4.6
- Changed the container to use the latest Ubuntu Noble 24.04

## 2.0.0 - [2024-07-11]
### Added
- Added pcre and pcre2 libraries

### Changed
- Changed the CI/CD to use woodpecker instead drone
- Changed the repository structure to support image versioning in releases
- Updated SDL 2.30.4

# v1 Changelog

## 2024-02-10
### Added
- Added a lot of libraries for newlib and clib2

### Updated
- Updated the clib4 libraries to the latest ones
- Updated AmiSSL SDK to v5.14

## 2023-10-22
### Changed
- The afxgroup images will stop being updated and the **Exp**erimental docker images, are introduced, that will include clib4 and latest binutils
- The SDK files are now under `/opt/ppc-amigaos/ppc-amigaos/SDK`

## 2023-08-21
### Changed
- Changed the way the clib2 by afxgroup libraries are installed, fixing some conflicts and making them exist in the Arm64 images

## 2023-08-15
### Added
- Added Arm based images for GCC 11
- Added afxgroup clib2 based images with a lot of third party libraries

### Changed
- Updated AmiSSL SDK to v5.10

## 2022-11-08
### Added
- Added the latest codesets 6.21 in the SDK

### Changed
- Changed the SDL 2 SDK to v2.24.0

## 2022-10-10
### Changed
- Changed the default SDK with 54.16 when building the gcc compilers
- Changed the SDL 2 SDK to v2.24.0-rc1
- Changed the makefiles for the base build for the cross compilers a lot, using the new clib2 by afxgroup
- Changed all images to be able to create different ones with the new clib2 by afxgroup
- Updated to newer version of Ubuntu at the gcc image

## 2022-09-10
### Added
- Experimental 68k setups. That's why I changed the file structure of this repo. WIP
- Updated the SDK image with the files from AmigaOS 4.1 SDK exec archive, that were missing.

### Changed
- Rebuild base ppc images with latest adtools changes
- Updated AmiSSL SDK to v5.3

## 2022-05-05
### Fixed
- The ExecSG SDK was missing
- The PATH was not added at the .bashrc file of the amidev user, so the compiler was not able to be found

## 2022-04-14
### Added
- Added GCC 11.2.0 image
- Added GL4ES SDK 1.2
- Added libCurl 7.79.1
- Added jansson 2.12.1
- Added libopenssl 1.1.1l
- Added sqlite3 3.34.0
- Added MiniGL 2.24
- Added libz 1.2.11
- Added liblua 5.2.4

### Changed
- Updated AmigaOS 4.1 SDK to 53.34
- Updated MUI 5.0 SDK to 20210831
- Updated OO library to v1.16 in the SDK image
- Removed sodero repo in base images
- Changed base images to use ubuntu:latest LTS image instead of phusion/baseimage
- Updated AmiSSL to 4.12 and moved it to the SDK image
- The sdk image renamed slightly
- Refactored gcc images to not use the AmigaVBCC image
- Images sizes reduced because of squashing their layers

## 2021-04-29
### Added
- Added Changelog file
- Added OS4 SDKs image
- Added the complete development environment dockerfile
- Added OO library in the SDK files
- Added GCC 10.3.0 image
- Added flawfinder and cppcheck tools

### Changed
- ppc-amigaos-x tags change to latest-base-gccx, where x is the number of installed GCC

### Fixed
- Fixed drone script to build and deploy the different images




The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).