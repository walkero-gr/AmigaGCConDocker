[![Build Status](https://drone-gh.intercube.gr/api/badges/walkero-gr/AmigaGCConDocker/status.svg)](https://drone-gh.intercube.gr/walkero-gr/AmigaGCConDocker)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/a2a863e7754e46c7bafaed8e47e8e41a)](https://www.codacy.com/gh/walkero-gr/AmigaGCConDocker/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=walkero-gr/AmigaGCConDocker&amp;utm_campaign=Badge_Grade)
[![CodeFactor](https://www.codefactor.io/repository/github/walkero-gr/amigagccondocker/badge)](https://www.codefactor.io/repository/github/walkero-gr/amigagccondocker)
[![Docker Pulls](https://img.shields.io/docker/pulls/walkero/amigagccondocker?color=brightgreen)](https://hub.docker.com/r/walkero/amigagccondocker)

# AmigaGCConDocker
AmigaGCConDocker is a project with different Docker images that are prepared as a base for cross compiling development environment for AmigaOS 4 (ppc-amigaos), based on GCC versions 8, 9 and 10. It is based on Ubuntu OS and has everything needed (gcc compiler, SDKs, libraries) for compiling your applications.

The purpose of the project is to be an up to date, flexible and out of the box solution for cross compiling applications for Amiga OS4 environments, using the GCC C/C++ compiler. Those images can be used on CI/CD solution for automatic testing, compiling, packaging and deployment.

## Docker images
AmigaGCConDocker is broken in different Docker images for better manipulation and updates. Those are separated by tags, which can be seen below, as well as their purpose.

- The `ppc-amigaos-gccX` images are the complete images that should be used for development. These include the gcc compiler as well as the available SDKs. Different ENV variables are set for easier usage and access to the libraries.

	Available tags:
	- **ppc-amigaos-gcc8**
	- **ppc-amigaos-gcc9**
	- **ppc-amigaos-gcc10**
	- **ppc-amigaos-gcc11**

- The `ppc-amigaos-sdks` is a small image which includes the SDK's installation, and is included in `ppc-amigaos-gccX` images above.
- The `ppc-base-gccX` images are the base images which are used to compile the different versions of gcc compiler from source. The binaries from these images are included in `ppc-amigaos-gccX` images above. 
	
	These can be used in different projects, in case someone needs a new compiled adtools and gcc for other docker containers

	Available tags:
	- **ppc-base-gcc8**
	- **ppc-base-gcc9**
	- **ppc-base-gcc10**
	- **ppc-base-gcc11**

## GCC versions

| docker image      | version |
| ----------------- | ------- |
| ppc-amigaos-gcc8  | v8.4.0  |
| ppc-amigaos-gcc9  | v9.1.0  |
| ppc-amigaos-gcc10 | v10.3.0 |
| ppc-amigaos-gcc11 | v11.1.0 |

## Included SDKs

| app           | version         | source                                                                  |
| ------------- | --------------- | ----------------------------------------------------------------------- |
| AmigaOS 4 SDK | 53.30           | http://www.hyperion-entertainment.com/                                  |
| MUI 5.x dev   | 5.0-2020R3      | http://muidev.de/downloads                                              |
| SDL           | v1.2.16-rc2     | https://github.com/AmigaPorts/SDL/releases/tag/v1.2.16-rc2-amigaos4     |
| SDL 2         | v2.0.14-update1 | https://github.com/AmigaPorts/SDL/releases/tag/v2.0.14-update1-amigaos4 |
| AmiSSL SDK    | 4.7             | https://github.com/jens-maus/amissl/releases/tag/4.7                    |
| OO library    | 1.16            | http://os4depot.net/?function=showfile&file=development/library/oo.lha  |
| FlexCat       | 2.18            | https://github.com/adtools/flexcat/releases/tag/2.18                    |
| lha           | v2 PMA          | https://github.com/jca02266/lha.git                                     |


## How to create a docker container

To create a container based on one of these images, run in the terminal any of the following lines, based on which version of GCC is preferred:

```bash
docker run -it --rm --name gcc8-ppc -v ${PWD}/code:/opt/code -w /opt/code walkero/amigagccondocker:ppc-amigaos-gcc8 /bin/bash
docker run -it --rm --name gcc9-ppc -v ${PWD}/code:/opt/code -w /opt/code walkero/amigagccondocker:ppc-amigaos-gcc9 /bin/bash
docker run -it --rm --name gcc10-ppc -v ${PWD}/code:/opt/code -w /opt/code walkero/amigagccondocker:ppc-amigaos-gcc10 /bin/bash
docker run -it --rm --name gcc11-ppc -v ${PWD}/code:/opt/code -w /opt/code walkero/amigagccondocker:ppc-amigaos-gcc11 /bin/bash
```

If you want to use it with **docker-compose**, you can create a *docker-compose.yml* file, with the following content. You can keep the lines of the preferred GCC version:

```yaml
version: '3'

services:
  gcc8-ppc:
    image: 'amigagccondocker:ppc-amigaos-gcc8'
    volumes:
      - './code:/opt/code'

  gcc9-ppc:
    image: 'amigagccondocker:ppc-amigaos-gcc9'
    volumes:
      - './code:/opt/code'

  gcc10-ppc:
    image: 'amigagccondocker:ppc-amigaos-gcc10'
    volumes:
      - './code:/opt/code'

  gcc11-ppc:
    image: 'amigagccondocker:ppc-amigaos-gcc11'
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

To compile your project you have to get into the container, inside the */opt/code/projectname* folder, which is shared with the host machine, and execute the compilation.

## Available SDK paths in ENV variables
The `ppc-amigaos-gccX` images have the following paths in ENV variables, which can be used in compilation of an application. It is preferred the separated libraries to be installed on their own folders, so to keep the the files isolated and easier to update them, or even find problems. It is also possible more libraries to be added externally, outside the Docker containers.

The current ENV paths are:
* **AOS4_SDK_INC**: /opt/sdk/ppc-amigaos/Include/include_h
* **AOS4_NET_INC**: /opt/sdk/ppc-amigaos/Include/netinclude
* **AOS4_NLIB_INC**: /opt/sdk/ppc-amigaos/newlib/include
* **AOS4_CLIB_INC**: /opt/sdk/ppc-amigaos/clib2/include
* **MUI50_INC**: /opt/sdk/MUI_5.0/C/include
* **SDL_INC**: /opt/sdk/SDL/include
* **SDL_LIB**: /opt/sdk/SDL/lib
* **SDL2_INC**: /opt/sdk/SDL2/include
* **SDL2_LIB**: /opt/sdk/SDL2/lib
* **AMISSL_INC**: /opt/sdk/AmiSSL/include
* **OO_INC**: /opt/sdk/OOLib/include

New paths can be set, by using environment variables on docker execution or inside the docker-compose.yml file, like:

```bash
docker run -it --rm --name gcc8-ppc -v ${PWD}/code:/opt/code -w /opt/code -e MY_INC="/your/folder/path" walkero/amigagccondocker:ppc-amigaos-gcc8 /bin/bash
```

docker-compose.yml
```yaml
version: '3'

services:
  gcc8-ppc:
    image: 'amigagccondocker:ppc-amigaos-gcc8'
	environment:
      MY_INC: "/opt/ext_sdk/MY/include_h"
    volumes:
      - './code:/opt/code'
      - './ext_sdk:/opt/ext_sdk'

  gcc9-ppc:
    image: 'amigagccondocker:ppc-amigaos-gcc9'
	environment:
      MY_INC: "/opt/ext_sdk/MY/include_h"
    volumes:
      - './code:/opt/code'
      - './ext_sdk:/opt/ext_sdk'

  gcc10-ppc:
    image: 'amigagccondocker:ppc-amigaos-gcc10'
	environment:
      MY_INC: "/opt/ext_sdk/MY/include_h"
    volumes:
      - './code:/opt/code'
      - './ext_sdk:/opt/ext_sdk'

  gcc11-ppc:
    image: 'amigagccondocker:ppc-amigaos-gcc11'
	environment:
      MY_INC: "/opt/ext_sdk/MY/include_h"
    volumes:
      - './code:/opt/code'
      - './ext_sdk:/opt/ext_sdk'
```


## VBCC user
The images have a user named **amidev**, and a group with the same name. The user and group ID is 1000, which matches host's machine user IDs. This way both users, from the host and the container, should have the same permissions on created files.

If you need to change the IDs with your own, set the following ENV variables when you start the docker containers

```
AMIDEV_USER_ID
AMIDEV_GROUP_ID
```

## VSCode setup
I recommend to use VSCode with [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension installed. You can use that extension to connect on the running GCC container. If you want automatically to set the extensions, set the user and other configuration for each container, after you attach to it select from action menu (F1) the "Remote-Containers: Open Container Configuration FIle" and add the configuration based on your preference. Below is my own example:
```json
{
	"extensions": [
		"donjayamanne.githistory",
		"eamodio.gitlens",
		"EditorConfig.EditorConfig",
		"Gruntfuggly.todo-tree",
		"ms-vscode.cpptools",
		"patricklee.vsnotes",
		"prb28.amiga-assembly",
		"SanaAjani.taskrunnercode"
	],
	"workspaceFolder": "/opt/code",
	"remoteUser": "amidev"
}
```

## Bug reports or feature request
If you have any issues with the images or you need help on using them or you would like to request any new feature, please contact me by opening an issue at https://github.com/walkero-gr/AmigaGCConDocker/issues
