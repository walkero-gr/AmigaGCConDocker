# os4, os3, mos
OS?=os4
# 8,9,10,11 can be used here
GCC?=11
# adtools, afxgroup
# CLIB2_REPO?=adtools
# release version
REL?=2.6.0
# gcc base image version
BASE_VER?=1.5.0

REPO?=walkero/amigagccondocker
TAG?=$(OS)-gcc$(GCC)-$(REL)
VOLUMES?=-v "${PWD}/tests":/opt/code
WORKSPACE?=-w /opt/code
NAME?=$(OS)-gcc$(GCC)

.PHONY: build buildnc shell push logs clean test release

default: help
help:
	@echo "This makefile helps on building cross-compiling docker image with gcc for AmigaOS 4"
	@echo "The available parameters can be seen below:"
	@echo ""
	@echo "build            - Build the Docker image"
	@echo "buildnc          - Build the Docker image without using cache"
	@echo "shell            - Create a container with the latest Docker"
	@echo "                   image and get into it"
	@echo ""
	@echo "Parameters that can be used with build rules:"
	@echo "GCC              - defines the gcc version."
	@echo "                   Possible values: 8 (default)/9/10/11"
	@echo "OS               - defines the cross-compiler target OS"
	@echo "                   Possible values: os4 (default)/os3/mos"
	@echo "BASE_VER         - defines the base image to be used"
	@echo ""

build:
	docker buildx build -f ./Dockerfile \
		-t $(REPO):$(TAG) \
		--progress plain \
		--build-arg OS=$(OS) \
		--build-arg GCC_VER=$(GCC) \
		--build-arg BASE_VER=$(BASE_VER) \
		--build-arg REL_VER=$(REL) .

buildnc:
	docker buildx build --no-cache -f ./Dockerfile \
		-t $(REPO):$(TAG) \
		--progress plain \
		--build-arg OS=$(OS) \
		--build-arg GCC_VER=$(GCC) \
		--build-arg BASE_VER=$(BASE_VER) \
		--build-arg REL_VER=$(REL) .

shell:
	docker run -it --rm --name $(TAG) $(VOLUMES) $(WORKSPACE) $(REPO):$(TAG) /bin/bash

push:
	docker push $(REPO):$(TAG)

logs:
	docker logs $(NAME)

clean:
	-docker rm -f $(NAME)

test:
	snyk test --docker $(REPO):$(TAG) --file=Dockerfile

release: build push
