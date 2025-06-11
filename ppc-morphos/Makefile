
OS?=ppc-morphos
REL?=1.0.0

REPO=walkero/amigagccondocker
TAG?=$(OS)-$(REL)
VOLUMES?=
# -v "${PWD}/out":/opt/out
WORKSPACE=-w /opt/code
NAME=$(TAG)

.PHONY: build buildnc build-exp shell push logs clean test release

default: help

help:
	@echo "This makefile helps on building cross-compiling docker image for MorphOS"
	@echo "The available parameters can be seen below:"
	@echo ""
	@echo "build            - Build the Docker image"
	@echo "buildnc          - Build the Docker image without using caching"
	@echo "shell            - Create a container with the latest Docker image and get"

build:
	docker buildx build -f ./Dockerfile \
		-t $(REPO):$(TAG) \
		--progress plain .

buildnc:
	docker buildx build --no-cache -f ./Dockerfile \
		-t $(REPO):$(TAG) \
		--progress plain .

shell:
	docker run -it --rm --name $(NAME) $(VOLUMES) $(WORKSPACE) $(REPO):$(TAG) /bin/bash

# push:
# 	docker push $(REPO):$(TAG)

# logs:
# 	docker logs $(NAME)

# clean:
# 	-docker rm -f $(NAME)

# test:
# 	snyk test --docker $(REPO):$(TAG) --file=Dockerfile

# release: build push
