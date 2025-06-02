[![Build Status](https://cicd.walkero.gr/job/AmigaGCCOnDocker/view/tags/job/os4-2.7.0/badge/icon?subject=ppc-amigaos%20Build&build=last)](https://cicd.walkero.gr/job/AmigaGCCOnDocker/view/tags/job/os4-2.7.0/)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/a2a863e7754e46c7bafaed8e47e8e41a)](https://www.codacy.com/gh/walkero-gr/AmigaGCConDocker/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=walkero-gr/AmigaGCConDocker&amp;utm_campaign=Badge_Grade)
[![CodeFactor](https://www.codefactor.io/repository/github/walkero-gr/amigagccondocker/badge)](https://www.codefactor.io/repository/github/walkero-gr/amigagccondocker)
[![Docker Pulls](https://img.shields.io/docker/pulls/walkero/amigagccondocker?color=brightgreen)](https://hub.docker.com/r/walkero/amigagccondocker)

# AmigaGCConDocker

AmigaGCConDocker is a project with different Docker images that can be used as the base for a cross-compiling development environment for AmigaOS 4 (ppc-amigaos) and MorphOS (ppc-morphos). They are based on GCC versions 8, 9, 10 and 11 and they are using Ubuntu OS. They have installed everything needed (gcc compiler, SDKs, libraries) for compiling your applications out of the box.

The purpose of the project is to be an up-to-date, flexible and out-of-the-box solution for cross-compiling applications for Amiga OS4 or MorphOS, using the GCC C/C++ compiler. Those Docker images can be used on CI/CD solutions for automatic testing, compiling, packaging and deployment.

## Docker images

AmigaGCConDocker is split into different Docker images for better manipulation and updates. Those are separated by tags, which can be seen below, as well as their purpose. 

There are **amd64** and **arm64** images, ready to be used on any system based on these cpu architectures.

The following images are the complete images that should be used for development. These include the gcc compiler as well as the available SDKs. Different ENV variables are set for easier usage and access to the libraries. 

### Available tags:

All the available docker images' tags can be seen at [Docker hub](https://hub.docker.com/repository/docker/walkero/amigagccondocker/tags)

#### AmigaOS 4

- GCC 6: `os4-gcc6`
- GCC 8: `os4-gcc8`
- GCC 9: `ppc-amigaos-gcc9`
- GCC 10: `ppc-amigaos-gcc10`
- GCC 11: `os4-gcc11`

The docker images with gcc versions 6,8,11 support newlib, clib2 and clib4 and they are the most updated releases.

The gcc v6 supports SPE CPU's and can be used to optimize code for systems like the A1222.

#### MorphOS

- mos-gcc

The MorphOS docker image containes multiple versions of gcc ready to be used.

## GCC versions supported

#### AmigaOS 4

| docker image | version |
| ------------ | ------- |
| gcc6         | 6.4.0   |
| gcc8         | 8.4.0   |
| gcc9         | 9.1.0   |
| gcc10        | 10.3.0  |
| gcc11        | 11.3.0  |

## Included SDKs

#### AmigaOS 4

| SDK           | version      | source                                       |
| ------------- | ------------ | -------------------------------------------- |
| AmigaOS 4 SDK | 54.16        | http://www.hyperion-entertainment.com/       |
| MUI 5.x dev   | 5.0-20210831 | http://muidev.de/downloads                   |
| AmiSSL SDK    | 5.20         | https://github.com/jens-maus/amissl/releases |

The list above is not complete and a lot more are included. A full list can be seen at `ppc-amigaos/scripts/libs/` folder in this repo. There are different bash scripts for each library that describe where they are downloaded from and how they are installed. All of them are installed under SDK path `/opt/ppc-amigaos/ppc-amigaos/SDK/local`. 

#### MorphOS

| SDK              | version      | source                                       |
| ---------------- | ------------ | -------------------------------------------- |
| MorphOS 3.18 SDK | 20230510     | http://www.hyperion-entertainment.com/       |


## Tools included

| Tool          | version | source                                      |
| ------------- | ------- | ------------------------------------------- |
| FlexCat       | 2.18    | https://github.com/adtools/flexcat/releases |
| lha           | v2 PMA  | https://github.com/jca02266/lha.git         |
| Lizard linter |         |
| cmake         | 3.28.3  |
| bison         | 3.8.2   |
| cppcheck      | 2.13.0  |
| flawfinder    | 2.0.19  |
| git           | 2.43.0  |
| subversion    | 1.14.3  |

The list above is not complete and a lot more are included. A full list can be seen in the `ppc-amigaos/scripts/setup-tools.sh` script, along with the way they are installed.

## How to create a docker container

To create a docker container based on one of these images, run in the terminal any of the following lines, based on which version of GCC is preferred:

```bash
docker run -it --rm --name gcc6 -v ${PWD}/code:/opt/code -w /opt/code walkero/amigagccondocker:os4-gcc6 /bin/bash
docker run -it --rm --name gcc8 -v ${PWD}/code:/opt/code -w /opt/code walkero/amigagccondocker:os4-gcc8 /bin/bash
docker run -it --rm --name gcc9 -v ${PWD}/code:/opt/code -w /opt/code walkero/amigagccondocker:ppc-amigaos-gcc9 /bin/bash
docker run -it --rm --name gcc10 -v ${PWD}/code:/opt/code -w /opt/code walkero/amigagccondocker:ppc-amigaos-gcc10 /bin/bash
docker run -it --rm --name gcc11 -v ${PWD}/code:/opt/code -w /opt/code walkero/amigagccondocker:os4-gcc11 /bin/bash

docker run -it --rm --name mos-gcc -v ${PWD}/code:/opt/code -w /opt/code walkero/amigagccondocker:mos-gcc /bin/bash
```

If you want to use it with **docker-compose**, you can create a *docker-compose.yml* file, with the following content. You can keep the lines of the preferred GCC version:

```yaml
services:
  gcc6:
    image: 'amigagccondocker:os4-gcc6'
    volumes:
      - './code:/opt/code'

  gcc8:
    image: 'amigagccondocker:os4-gcc8'
    volumes:
      - './code:/opt/code'

  gcc9:
    image: 'amigagccondocker:ppc-amigaos-gcc9'
    volumes:
      - './code:/opt/code'

  gcc10:
    image: 'amigagccondocker:ppc-amigaos-gcc10'
    volumes:
      - './code:/opt/code'

  gcc11:
    image: 'amigagccondocker:os4-gcc11'
    volumes:
      - './code:/opt/code'

  mos-gcc:
    image: 'amigagccondocker:mos-gcc'
    volumes:
      - './code:/opt/code'
```

And then you can create and get into each container by doing the following:

```bash
docker-compose up -d
docker-compose exec gcc6 bash
docker-compose exec gcc8 bash
docker-compose exec gcc9 bash
docker-compose exec gcc10 bash
docker-compose exec gcc11 bash

docker-compose exec mos-gcc bash
```

To compile your projects, you have to get inside the container, change directory to the `/opt/code/projectname` folder, which is shared with the host machine, and compile it.

## Available SDK paths in ENV variables
Every docker image has some ready to be used environment variables, that can be useful to you. To view them get inside the container and run `printenv`.

New variables can be set, by using `environment` variables on docker execution or inside the docker-compose.yml file, like:

```bash
docker run -it --rm --name gcc11 -v ${PWD}/code:/opt/code -w /opt/code -e MY_INC="/your/folder/path" walkero/amigagccondocker:os4-gcc11 /bin/bash
```

docker-compose.yml
```yaml
services:
  gcc11-ppc:
    image: 'amigagccondocker:os4-gcc11'
    environment:
      MY_INC: "/opt/ext_sdk/MY/include_h"
    volumes:
      - './code:/opt/code'
      - './ext_sdk:/opt/ext_sdk'
```

## amidev user
The images have a user named **amidev**, and a group with the same name. The user and group IDs are 1000, which usually matches the host's machine user IDs. This way, both the host and the container users, should have the same file permissions.

If you need to change the IDs with your own, set the following ENV variables when you start the docker containers

```
AMIDEV_USER_ID
AMIDEV_GROUP_ID
```

## VSCode setup
I recommend using VSCode with [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension installed. You can use that extension to connect to the running GCC container. If you want automatically to set the extensions, set the user and other configurations for each container, after you attach to it, select from the action menu (F1) the "Remote-Containers: Open Container Configuration File" and add the configuration based on your preference. Below is my example and a list of plugins I like to use:
```json
{
	"extensions": [
		"donjayamanne.githistory",
		"eamodio.gitlens",
		"editorconfig.editorconfig",
		"github.copilot",
		"github.copilot-chat",
		"gruntfuggly.todo-tree",
		"jbenden.c-cpp-flylint",
		"patricklee.vsnotes",
		"sanaajani.taskrunnercode",
		"twxs.cmake",
		"ms-vscode.cpptools",
		"paragdiwan.gitpatch",
		"johnstoncode.svn-scm"
	],
	"workspaceFolder": "/opt/code/grafx2",
	"remoteUser": "amidev"
}
```

## Bug reports or feature request
If you have any issues with the images or you need help on using them or you would like to request any new feature, please contact me by opening an issue at https://github.com/walkero-gr/AmigaGCConDocker/issues
