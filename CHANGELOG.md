# Changelog
All notable changes to this project will be documented in this file.

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