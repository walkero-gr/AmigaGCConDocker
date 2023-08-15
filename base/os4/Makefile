# os4, os3, mos
OS?=os4
# 8,9,10,11 can be used here
GCC?=8
# adtools, afxgroup
CLIB2_REPO?=adtools
# apt,git,release
CLIB2_SRC?=apt
# OS4 SDK version
SDK?=54.16

REPO=walkero/amigagccondocker
TAG?=$(OS)-base-gcc$(GCC)-$(CLIB2_REPO)
NAME=$(TAG)
# VOLUMES?=-v "${PWD}/misc":/opt/misc
WORKSPACE=-w /opt/adtools
FILESPATH=./files
REPOSPATH=./repos

.PHONY: build buildnc shell push logs clonerepos pullrepos clean test release

default: help

help:
	@echo "This makefile helps on building cross-compiling gcc for AmigaOS 4 PPC"
	@echo "The available parameters can be seen below:"
	@echo ""
	@echo "build            - Build the Docker image"
	@echo "buildnc          - Pull the latest repos' code and build the Docker image"
	@echo "                   without using caching"
	@echo "shell            - Create a container with the latest Docker image and get"
	@echo "                   into it"
	@echo "clonerepos       - Clone the necessary repositories under repos folder."
	@echo "pullrepos        - Pull the latest code for the projects under repos folder."
	@echo "clean            - Remove the docker container, if this still exists."
	@echo ""
	@echo "Parameters that can be used with build rules:"
	@echo "GCC              - defines the gcc version."
	@echo "                   Possible values: 8 (default)/9/10/11"
	@echo "CLIB2_REPO       - defines the clib2 repo to be cloned and used."
	@echo "                   Possible values: adtools (default)/afxgroup"
	@echo "CLIB2_SRC        - defines the afgroup clib2 source to be used."
	@echo "                   Possible values: apt (default)/git/release"
	@echo "                   Used only when CLIB2_REPO is set to afxgroup"
	@echo "OS               - defines the cross-compiler target OS"
	@echo "                   Possible values: os4 (default)/os3/mos"
	@echo ""

build:
	docker build -f ./Dockerfile \
		-t $(REPO):$(TAG) \
		--progress plain \
		--build-arg GCC_VER=$(GCC) \
		--build-arg FILES_PATH=$(FILESPATH) \
		--build-arg CLIB2_REPO=$(CLIB2_REPO) \
		--build-arg CLIB2_SRC=$(CLIB2_SRC) \
		--build-arg SDK_VER=$(SDK) .

buildnc:
	docker build --no-cache -f ./Dockerfile \
		-t $(REPO):$(TAG) \
		--progress plain \
		--build-arg GCC_VER=$(GCC) \
		--build-arg FILES_PATH=$(FILESPATH) \
		--build-arg CLIB2_REPO=$(CLIB2_REPO) \
		--build-arg CLIB2_SRC=$(CLIB2_SRC) \
		--build-arg SDK_VER=$(SDK) .

shell:
	docker run -it --rm --name $(NAME) $(VOLUMES) $(WORKSPACE) $(REPO):$(TAG) /bin/bash

push:
	docker push $(REPO):$(TAG)

logs:
	docker logs $(NAME)

clonerepos:
	git clone https://github.com/sba1/adtools              $(REPOSPATH)/adtools
	git clone https://github.com/3246251196/adtools.git    $(REPOSPATH)/adtools-rjd324
	git clone https://github.com/bminor/binutils-gdb       $(REPOSPATH)/binutils-gdb
	git clone https://github.com/coreutils/coreutils       $(REPOSPATH)/coreutils
	git clone https://github.com/coreutils/gnulib          $(REPOSPATH)/gnulib

pullrepos:
	git -C $(REPOSPATH)/adtools pull
	git -C $(REPOSPATH)/adtools-rjd324 pull
	git -C $(REPOSPATH)/binutils-gdb pull
	git -C $(REPOSPATH)/coreutils pull
	git -C $(REPOSPATH)/gnulib pull

clean:
	-docker rm -f $(NAME)

test:
	snyk test --docker $(REPO):$(TAG) --file=Dockerfile

release: build push
