# os4, os3, mos
OS?=os4
# 8,9,10,11 can be used here
GCC?=8
# adtools, afxgroup
CLIB2_REPO?=adtools

REPO?=walkero/amigagccondocker
TAG?=$(OS)-gcc$(GCC)-$(CLIB2_REPO)
VOLUMES?=-v "${PWD}/code":/opt/code
WORKSPACE?=-w /opt/code
NAME?=$(OS)-gcc$(GCC)-$(CLIB2_REPO)

.PHONY: build buildnc shell push logs clean test release

default: help
help:
	@echo "This makefile helps on building cross-compiling docker image with gcc for"
	@echo "AmigaOS 4, AmigaOS 3 (WIP) and MorphOS (WIP)"
	@echo "The available parameters can be seen below:"
	@echo ""
	@echo "build            - Build the Docker image"
	@echo "buildnc          - Build the Docker image without using cache"
	@echo "shell            - Create a container with the latest Docker image and get"
	@echo "                   into it"
# @echo "clonerepos       - Clone the necessary repositories under repos folder."
# @echo "pullrepos        - Pull the latest code for the projects under repos folder."
# @echo "clean            - Remove the docker container, if this still exists."
	@echo ""
	@echo "Parameters that can be used with build rules:"
	@echo "GCC              - defines the gcc version."
	@echo "                   Possible values: 8 (default)/9/10/11"
	@echo "CLIB2_REPO       - defines the clib2 repo to be cloned and used."
	@echo "                   Possible values: adtools (default)/afxgroup"
	@echo "OS               - defines the cross-compiler target OS"
	@echo "                   Possible values: os4 (default)/os3/mos"
	@echo ""

build:
	docker build -f ./$(OS).Dockerfile \
		-t $(REPO):$(TAG) \
		--progress plain \
		--build-arg OS=$(OS) \
		--build-arg CLIB2_REPO=$(CLIB2_REPO) \
		--build-arg GCC_VER=$(GCC) .

buildnc:
	docker build --no-cache -f ./$(OS).Dockerfile \
		-t $(REPO):$(TAG) \
		--progress plain \
		--build-arg OS=$(OS) \
		--build-arg CLIB2_REPO=$(CLIB2_REPO) \
		--build-arg GCC_VER=$(GCC) .

shell:
	docker run -it --rm --name $(NAME)$(TAG) $(VOLUMES) $(WORKSPACE) $(REPO):$(TAG) /bin/bash

push:
	docker push $(REPO):$(TAG)

logs:
	docker logs $(NAME)

clean:
	-docker rm -f $(NAME)

test:
	snyk test --docker $(REPO):$(TAG) --file=Dockerfile

release: build push
