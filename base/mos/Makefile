
# 4-11 can be used here
GCC?=11

REPO=walkero/amigagccondocker
TAG?=mos-base-gcc$(GCC)
NAME=$(TAG)
VOLUMES?=-v "${PWD}/out":/opt/out
WORKSPACE=-w /tmp
REPOSPATH=./repos

.PHONY: build buildnc shell push logs clean test release

default: help

help:
	@echo "This makefile helps on building cross-compiling gcc for MorphOS"
	@echo "The available parameters can be seen below:"
	@echo ""
	@echo "build            - Build the Docker image"
	@echo "buildnc          - Pull the latest repos' code and build the Docker image"
	@echo "                   without using caching"
	@echo "shell            - Create a container with the latest Docker image and get"
	@echo "                   into it"
	@echo "clean            - Remove the docker container, if this still exists."
	@echo ""
	@echo "Parameters that can be used with build rules:"
	@echo "GCC              - defines the gcc version."
	@echo "                   Possible values: 4-11 (default)"
	@echo ""

build:
	docker build -f ./Dockerfile \
		-t $(REPO):$(TAG) \
		--progress plain \
		--build-arg GCC_VER=$(GCC) .

buildnc:
	docker build --no-cache -f ./Dockerfile \
		-t $(REPO):$(TAG) \
		--progress plain \
		--build-arg GCC_VER=$(GCC) .

shell:
	docker run -it --rm --name $(NAME) $(VOLUMES) $(WORKSPACE) $(REPO):$(TAG) /bin/bash

push:
	docker push $(REPO):$(TAG)

logs:
	docker logs $(NAME)

clean:
	-docker rm -f $(NAME)

test:
	snyk test --docker $(REPO):$(TAG) --file=Dockerfile

release: build push
