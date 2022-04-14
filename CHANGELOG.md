# Changelog
All notable changes to this project will be documented in this file.

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