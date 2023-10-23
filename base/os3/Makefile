
OS=os3
REPO=walkero/amigagccondocker
TAG?=$(OS)-base-gcc
NAME=$(TAG)
WORKSPACE=-w /opt/m68k-amigaos
FILESPATH=./files
REPOSPATH=./repos

.PHONY: help build buildnc shell push logs clonerepos pullrepos clean test release

default: help

help:
	@echo "This makefile helps on building cross-compiling gcc for AmigaOS 3 m68k"
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

build:
	docker build -f ./Dockerfile \
		-t $(REPO):$(TAG) \
		--progress plain \
		--build-arg GCC_VER=$(GCC) \
		--build-arg REPOS_PATH=$(REPOSPATH) \
		--build-arg FILES_PATH=$(FILESPATH) \
		--build-arg CLIB2_REPO=$(CLIB2_REPO) \
		--build-arg SDK_VER=$(SDK) .

buildnc: pullrepos
	docker build --no-cache -f ./Dockerfile \
		-t $(REPO):$(TAG) \
		--progress plain \
		--build-arg GCC_VER=$(GCC) \
		--build-arg REPOS_PATH=$(REPOSPATH) \
		--build-arg FILES_PATH=$(FILESPATH) \
		--build-arg CLIB2_REPO=$(CLIB2_REPO) \
		--build-arg SDK_VER=$(SDK) .

shell:
	docker run -it --rm --name $(NAME) $(WORKSPACE) $(REPO):$(TAG) /bin/bash

push:
	docker push $(REPO):$(TAG)

logs:
	docker logs $(NAME)

clonerepos:
	git clone https://github.com/bebbo/amiga-gcc.git $(REPOSPATH)/amiga-gcc
	git clone https://github.com/BartmanAbyss/vscode-amiga-debug.git $(REPOSPATH)/vscode-amiga-debug

pullrepos:
	git -C $(REPOSPATH)/amiga-gcc pull
	git -C $(REPOSPATH)/vscode-amiga-debug pull

clean:
	-docker rm -f $(NAME)

test:
	snyk test --docker $(REPO):$(TAG) --file=Dockerfile

release: build push
