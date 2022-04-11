GCC ?= 8
SDK ?= 53.30
REPO ?= walkero/amigagccondocker
TAG ?= ppc-base-gcc$(GCC)
NAME ?= ppc-base-gcc$(GCC)
WORKSPACE ?= -w /opt/adtools
FILESPATH ?= files
REPOSPATH ?= ./repos

.PHONY: build buildnc shell push logs clonerepos pullrepos clean test release

default: build

build:
	docker build --squash -f ./Dockerfile$(SDK) \
		-t $(REPO):$(TAG) \
		--build-arg GCC_VER=$(GCC) \
		--build-arg REPOS_PATH=$(REPOSPATH) \
		--build-arg FILES_PATH=$(FILESPATH) \
		--build-arg SDK_VER=$(SDK) .

buildnc:
	docker build --no-cache --squash -f ./Dockerfile$(SDK) \
		-t $(REPO):$(TAG) \
		--build-arg GCC_VER=$(GCC) \
		--build-arg REPOS_PATH=$(REPOSPATH) \
		--build-arg FILES_PATH=$(FILESPATH) \
		--build-arg SDK_VER=$(SDK) .

shell:
	docker run -it --rm --name $(NAME) $(WORKSPACE) $(REPO):$(TAG) /bin/bash

push:
	docker push $(REPO):$(TAG)

logs:
	docker logs $(NAME)

clonerepos:
	git clone https://github.com/sba1/adtools          $(REPOSPATH)/adtools
	git clone https://github.com/bminor/binutils-gdb   $(REPOSPATH)/binutils-gdb
	git clone https://github.com/coreutils/coreutils   $(REPOSPATH)/coreutils
	git clone https://github.com/coreutils/gnulib      $(REPOSPATH)/gnulib

pullrepos:
	git -C $(REPOSPATH)/adtools pull
	git -C $(REPOSPATH)/binutils-gdb pull
	git -C $(REPOSPATH)/coreutils pull
	git -C $(REPOSPATH)/gnulib pull

clean:
	-docker rm -f $(NAME)

test:
	snyk test --docker $(REPO):$(TAG) --file=Dockerfile

release: build push
