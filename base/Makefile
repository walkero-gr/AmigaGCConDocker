GCC ?= 8 # 8,9,10,11 can be used here
CLIB2REPO ?= adtools # or use afxgroup
CLIB2TAG :=

SDK := 54.16
REPO ?= walkero/amigagccondocker
TAG ?= ppc-base-gcc$(GCC)
NAME ?= ppc-base-gcc$(GCC)
WORKSPACE ?= -w /opt/adtools
FILESPATH ?= files
REPOSPATH ?= ./repos

ifeq ($(CLIB2REPO), afxgroup)
override CLIB2TAG = -newclib2
override TAG = ppc-base-gcc$(GCC)$(CLIB2TAG)
endif

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
	@echo "GCC=x            - defines the gcc version. Possible values 8/9/10/11"
	@echo "CLIB2REPO        - defines the clib2 repo to be cloned and used."
	@echo "                   Possible values adtools/afxgroup"
	@echo ""

build:
	docker build --squash -f ./Dockerfile \
		-t $(REPO):$(TAG) \
		--build-arg GCC_VER=$(GCC) \
		--build-arg REPOS_PATH=$(REPOSPATH) \
		--build-arg FILES_PATH=$(FILESPATH) \
		--build-arg CLIB2_REPO=$(CLIB2REPO) \
		--build-arg SDK_VER=$(SDK) .

buildnc: pullrepos
	docker build --no-cache --squash -f ./Dockerfile \
		-t $(REPO):$(TAG) \
		--build-arg GCC_VER=$(GCC) \
		--build-arg REPOS_PATH=$(REPOSPATH) \
		--build-arg FILES_PATH=$(FILESPATH) \
		--build-arg CLIB2_REPO=$(CLIB2REPO) \
		--build-arg SDK_VER=$(SDK) .

shell:
	docker run -it --rm --name $(NAME)$(CLIB2TAG) $(WORKSPACE) $(REPO):$(TAG) /bin/bash

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
