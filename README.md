[![Build Status](https://drone-gh.intercube.gr/api/badges/walkero-gr/AmigaGCConDocker/status.svg)](https://drone-gh.intercube.gr/walkero-gr/AmigaGCConDocker)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/a2a863e7754e46c7bafaed8e47e8e41a)](https://www.codacy.com/gh/walkero-gr/AmigaGCConDocker/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=walkero-gr/AmigaGCConDocker&amp;utm_campaign=Badge_Grade)
[![CodeFactor](https://www.codefactor.io/repository/github/walkero-gr/amigagccondocker/badge)](https://www.codefactor.io/repository/github/walkero-gr/amigagccondocker)
[![Docker Pulls](https://img.shields.io/docker/pulls/walkero/amigagccondocker?color=brightgreen)](https://hub.docker.com/r/walkero/amigagccondocker)

# AmigaGCConDocker

AmigaGCConDocker is a project with different Docker images that can be used as the base for a cross-compiling development environment for AmigaOS 4 (ppc-amigaos). They are based on GCC versions 8, 9, 10 and 11 and they are using Ubuntu OS. They have installed everything needed (gcc compiler, SDKs, libraries) for compiling your applications out of the box.

The purpose of the project is to be an up-to-date, flexible and out-of-the-box solution for cross-compiling applications for Amiga OS4, using the GCC C/C++ compiler. Those Docker images can be used on CI/CD solutions for automatic testing, compiling, packaging and deployment.

## Docker images

AmigaGCConDocker is split into different Docker images for better manipulation and updates. Those are separated by tags, which can be seen below, as well as their purpose. 

There are **amd64** and **arm64** images, ready to be used on any system having these cpu architects.

The `os4-gccX-adtools` images are the complete images that should be used for development. These include the gcc compiler as well as the available SDKs. Different ENV variables are set for easier usage and access to the libraries. 

  Available tags:
  - GCC 8: `os4-gcc8-adtools`
  - GCC 9: `os4-gcc9-adtools`
  - GCC 10: `os4-gcc10-adtools`
  - GCC 11: `os4-gcc11-adtools`

The `os4-base-adtools` are images that were used to compile gcc. There binaries and extra files are all included in the `os4-gccX-adtools` and `os4-gccX-exp`, therefore they are not useful for development.

  Available tags:
  - GCC 8: `os4-base-gcc8-adtools`
  - GCC 9: `os4-base-gcc9-adtools`
  - GCC 10: `os4-base-gcc10-adtools`
  - GCC 11: `os4-base-gcc11-adtools`

## Experimental docker images

There is also the `os4-gcc11-exp` that includes the new [clib4 by afxgroup](https://github.com/afxgroup/clib2) which is a WIP. In future releases it will include updated versions of gcc, binutils and other components.

This image has the clib4 and a plethora of compatible third party libraries installed. This can be used on application/games ports, but have in mind, as it is experimental, it might get broken at any time. If that happens please open an [issue](https://github.com/walkero-gr/AmigaGCConDocker/issues).

## GCC versions

| docker image      | version |
| ----------------- | ------- |
| gcc8  | 8.4.0  |
| gcc9  | 9.1.0  |
| gcc10 | 10.3.0 |
| gcc11 | 11.3.0 |

## Included SDKs

| SDK           | version      | source                                                                            |
| ------------- | ------------ | --------------------------------------------------------------------------------- |
| AmigaOS 4 SDK | 54.16        | http://www.hyperion-entertainment.com/                                            |
| MUI 5.x dev   | 5.0-20210831 | http://muidev.de/downloads                                                        |
| SDL           | v1.2.16-rc2  | https://github.com/AmigaPorts/SDL/releases               |
| SDL 2         | v2.26.5      | https://github.com/AmigaPorts/SDL-2.0/releases |
| AmiSSL SDK    | 5.11         | https://github.com/jens-maus/amissl/releases    |
| FlexCat       | 2.18         | https://github.com/adtools/flexcat/releases                              |
| lha           | v2 PMA       | https://github.com/jca02266/lha.git                                               |
| gl4es         | 1.2       | https://github.com/kas1e/GL4ES-SDK/releases                                               |
| libcurl         | 7.79.1       | http://os4depot.net/?function=showfile&file=development/library/misc/libcurl.lha            |
| jansson | 2.12.1 | http://os4depot.net/?function=showfile&file=development/library/misc/jansson_library.lha |
| libopenssl | 1.1.1l | http://os4depot.net/?function=showfile&file=development/library/misc/libopenssl.lha
| sqlite | 3.34.0 | http://aminet.net/package/biz/dbase/sqlite-3.34.0-amiga
| minigl | 2.24 | http://os4depot.net/?function=showfile&file=driver/graphics/minigl.lha
| libz | 1.2.11 | http://os4depot.net/?function=showfile&file=development/library/misc/libz.lha
| liblua | 5.2.4 | http://os4depot.net/?function=showfile&file=development/language/liblua.lha
| codesets | 6.21 | https://github.com/jens-maus/libcodesets

The list above is not complete and a lot more are included. They can be found under `/opt/sdk/ppc-amigaos/local` folder.

## How to create a docker container

To create a docker container based on one of these images, run in the terminal any of the following lines, based on which version of GCC is preferred:

```bash
docker run -it --rm --name gcc8-ppc -v ${PWD}/code:/opt/code -w /opt/code walkero/amigagccondocker:os4-gcc8-adtools /bin/bash
docker run -it --rm --name gcc9-ppc -v ${PWD}/code:/opt/code -w /opt/code walkero/amigagccondocker:os4-gcc9-adtools /bin/bash
docker run -it --rm --name gcc10-ppc -v ${PWD}/code:/opt/code -w /opt/code walkero/amigagccondocker:os4-gcc10-adtools /bin/bash
docker run -it --rm --name gcc11-ppc -v ${PWD}/code:/opt/code -w /opt/code walkero/amigagccondocker:os4-gcc11-adtools /bin/bash
```

If you want to use it with **docker-compose**, you can create a *docker-compose.yml* file, with the following content. You can keep the lines of the preferred GCC version:

```yaml
version: '3'

services:
  gcc8-ppc:
    image: 'amigagccondocker:os4-gcc8-adtools'
    volumes:
      - './code:/opt/code'

  gcc9-ppc:
    image: 'amigagccondocker:os4-gcc9-adtools'
    volumes:
      - './code:/opt/code'

  gcc10-ppc:
    image: 'amigagccondocker:os4-gcc10-adtools'
    volumes:
      - './code:/opt/code'

  gcc11-ppc:
    image: 'amigagccondocker:os4-gcc11-adtools'
    volumes:
      - './code:/opt/code'
```

And then you can create and get into each container by doing the following:

```bash
docker-compose up -d
docker-compose gcc8-ppc exec bash
docker-compose gcc9-ppc exec bash
docker-compose gcc10-ppc exec bash
docker-compose gcc11-ppc exec bash
```

To compile your project you have to get into the container, inside the `/opt/code/projectname` folder, which is shared with the host machine, and compile it.

## Available SDK paths in ENV variables
The `os4-gccX-adtools` images have the following paths in ENV variables, which can be used in the compilation of an application. It is preferred the separated libraries be installed in their folders, to keep the files isolated and easier to update them, or even find problems. It is also possible for more libraries to be added externally, outside the Docker containers.

The newer docker images have the following ENV paths:
* **SDK_PATH**: /opt/ppc-amigaos/ppc-amigaos/SDK
* **MUI50_INC**: /opt/ppc-amigaos/ppc-amigaos/SDK/MUI_5.0/C/include

The older docker images (created before Oct'23) have the following ENV paths:
* **AOS4_SDK_INC**: /opt/sdk/ppc-amigaos/Include/include_h
* **AOS4_NET_INC**: /opt/sdk/ppc-amigaos/Include/netinclude
* **AOS4_NLIB_INC**: /opt/sdk/ppc-amigaos/newlib/include
* **AOS4_CLIB_INC**: /opt/sdk/ppc-amigaos/clib2/include
* **MUI50_INC**: /opt/sdk/MUI_5.0/C/include

New paths can be set, by using `environment` variables on docker execution or inside the docker-compose.yml file, like:

```bash
docker run -it --rm --name gcc8-ppc -v ${PWD}/code:/opt/code -w /opt/code -e MY_INC="/your/folder/path" walkero/amigagccondocker:os4-gcc8 /bin/bash
```

docker-compose.yml
```yaml
version: '3'

services:
  gcc8-ppc:
    image: 'amigagccondocker:os4-gcc8'-adtools
  environment:
    MY_INC: "/opt/ext_sdk/MY/include_h"
  volumes:
    - './code:/opt/code'
    - './ext_sdk:/opt/ext_sdk'

  gcc9-ppc:
    image: 'amigagccondocker:os4-gcc9'-adtools
  environment:
    MY_INC: "/opt/ext_sdk/MY/include_h"
  volumes:
    - './code:/opt/code'
    - './ext_sdk:/opt/ext_sdk'

  gcc10-ppc:
    image: 'amigagccondocker:os4-gcc10-adtools'
  environment:
    MY_INC: "/opt/ext_sdk/MY/include_h"
  volumes:
    - './code:/opt/code'
    - './ext_sdk:/opt/ext_sdk'

  gcc11-ppc:
    image: 'amigagccondocker:os4-gcc11-adtools'
  environment:
    MY_INC: "/opt/ext_sdk/MY/include_h"
  volumes:
    - './code:/opt/code'
    - './ext_sdk:/opt/ext_sdk'

  gcc11-ppc-afxgroup:
    image: 'amigagccondocker:os4-gcc11-afxgroup'
  environment:
    MY_INC: "/opt/ext_sdk/MY/include_h"
  volumes:
    - './code:/opt/code'
    - './ext_sdk:/opt/ext_sdk'
```

## amidev user
The images have a user named **amidev**, and a group with the same name. The user and group ID is 1000, which usually matches the host's machine user IDs. This way, both the host and the container users, should have the same file permissions.

If you need to change the IDs with your own, set the following ENV variables when you start the docker containers

```
AMIDEV_USER_ID
AMIDEV_GROUP_ID
```

## VSCode setup
I recommend using VSCode with [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension installed. You can use that extension to connect to the running GCC container. If you want automatically to set the extensions, set the user and other configurations for each container, after you attach to it select from the action menu (F1) the "Remote-Containers: Open Container Configuration File" and add the configuration based on your preference. Below is my example:
```json
{
	"extensions": [
		"donjayamanne.githistory",
		"eamodio.gitlens",
		"EditorConfig.EditorConfig",
		"Gruntfuggly.todo-tree",
		"jbenden.c-cpp-flylint",
		"patricklee.vsnotes",
		"SanaAjani.taskrunnercode",
		"twxs.cmake"
	],
	"workspaceFolder": "/opt/code",
	"remoteUser": "amidev"
}
```

## Bug reports or feature request
If you have any issues with the images or you need help on using them or you would like to request any new feature, please contact me by opening an issue at https://github.com/walkero-gr/AmigaGCConDocker/issues