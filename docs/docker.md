# How to create a docker container

To create a docker container based on one of these images, run in the terminal any of the following lines, based on which version of GCC is preferred:

```bash
docker run -it --rm --name gcc6 -v ${PWD}/code:/opt/code -w /opt/code walkero/amigagccondocker:os4-gcc6 /bin/bash
docker run -it --rm --name gcc8 -v ${PWD}/code:/opt/code -w /opt/code walkero/amigagccondocker:os4-gcc8 /bin/bash
docker run -it --rm --name gcc9 -v ${PWD}/code:/opt/code -w /opt/code walkero/amigagccondocker:ppc-amigaos-gcc9 /bin/bash
docker run -it --rm --name gcc10 -v ${PWD}/code:/opt/code -w /opt/code walkero/amigagccondocker:ppc-amigaos-gcc10 /bin/bash
docker run -it --rm --name gcc11 -v ${PWD}/code:/opt/code -w /opt/code walkero/amigagccondocker:os4-gcc11 /bin/bash
docker run -it --rm --name gcc13 -v ${PWD}/code:/opt/code -w /opt/code walkero/amigagccondocker:os4-gcc13 /bin/bash

docker run -it --rm --name mos-gcc -v ${PWD}/code:/opt/code -w /opt/code walkero/amigagccondocker:mos-gcc /bin/bash
```

If you want to use it with **docker-compose**, you can create a *docker-compose.yml* file, with the following content. You can keep the lines of the preferred GCC version:

```yaml
services:
  gcc6:
    image: 'walkero/amigagccondocker:os4-gcc6'
    hostname: ppc-amigaos-gcc6
    volumes:
      - './code:/opt/code'
    extra_hosts:
      - "host.docker.internal:host-gateway"

  gcc8:
    image: 'walkero/amigagccondocker:os4-gcc8'
    hostname: ppc-amigaos-gcc8
    volumes:
      - './code:/opt/code'
    extra_hosts:
      - "host.docker.internal:host-gateway"

  gcc9:
    image: 'walkero/amigagccondocker:ppc-amigaos-gcc9'
    hostname: ppc-amigaos-gcc9
    volumes:
      - './code:/opt/code'
    extra_hosts:
      - "host.docker.internal:host-gateway"

  gcc10:
    image: 'walkero/amigagccondocker:ppc-amigaos-gcc10'
    hostname: ppc-amigaos-gcc10
    volumes:
      - './code:/opt/code'
    extra_hosts:
      - "host.docker.internal:host-gateway"

  gcc11:
    image: 'walkero/amigagccondocker:os4-gcc11'
    hostname: ppc-amigaos-gcc11
    volumes:
      - './code:/opt/code'
    extra_hosts:
      - "host.docker.internal:host-gateway"

  gcc13:
    image: 'walkero/amigagccondocker:os4-gcc13'
    hostname: ppc-amigaos-gcc13
    volumes:
      - './code:/opt/code'
    extra_hosts:
      - "host.docker.internal:host-gateway"

  mos-gcc:
    image: 'walkero/amigagccondocker:mos-gcc'
    hostname: ppc-morphos
    volumes:
      - './code:/opt/code'
    extra_hosts:
      - "host.docker.internal:host-gateway"
```

And then you can create and get into each container by doing the following:

```bash
docker-compose up -d
docker-compose exec gcc6 bash
docker-compose exec gcc8 bash
docker-compose exec gcc9 bash
docker-compose exec gcc10 bash
docker-compose exec gcc11 bash
docker-compose exec gcc13 bash

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
    image: 'walkero/amigagccondocker:os4-gcc11'
    hostname: ppc-amigaos-gcc11
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
