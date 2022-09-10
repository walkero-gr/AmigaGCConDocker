GCC ?= 6
NDK ?= 3.9
REPO ?= walkero/amigagccondocker
TAG ?= 68k-base-gcc$(GCC)
NAME ?= 68k-base-gcc$(GCC)
WORKSPACE ?= -w /opt/m68k-amigaos
FILESPATH ?= files
REPOSPATH ?= ./repos

.PHONY: build buildnc shell push logs clonerepos pullrepos clean test release

default: build

build:
	docker build --squash -f ./Dockerfile \
		-t $(REPO):$(TAG) \
		--build-arg GCC_VER=$(GCC) \
		--build-arg REPOS_PATH=$(REPOSPATH) \
		--build-arg FILES_PATH=$(FILESPATH) \
		--build-arg NDK_VER=$(NDK) .

buildnc:
	docker build --no-cache --squash -f ./Dockerfile \
		-t $(REPO):$(TAG) \
		--build-arg GCC_VER=$(GCC) \
		--build-arg REPOS_PATH=$(REPOSPATH) \
		--build-arg FILES_PATH=$(FILESPATH) \
		--build-arg NDK_VER=$(NDK) .

shell:
	docker run -it --rm --name $(NAME) $(WORKSPACE) $(REPO):$(TAG) /bin/bash

push:
	docker push $(REPO):$(TAG)

logs:
	docker logs $(NAME)

clonerepos:
	git clone https://github.com/bebbo/amiga-gcc.git $(REPOSPATH)/amiga-gcc

pullrepos:
	git -C $(REPOSPATH)/amiga-gcc pull

clean:
	-docker rm -f $(NAME)

test:
	snyk test --docker $(REPO):$(TAG) --file=Dockerfile

release: build push
