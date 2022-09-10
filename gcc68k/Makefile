GCC ?= 6
REPO ?= walkero/amigagccondocker
TAG ?= 68k-amigaos-gcc$(GCC)
VOLUMES ?= -v "${PWD}/../code":/opt/code
WORKSPACE ?= -w /opt/code
NAME ?= 68k-amigaos-gcc$(GCC)

.PHONY: build buildnc shell push logs clean test release

default: build

build:
	docker build --squash \
		-t $(REPO):$(TAG) \
		--build-arg GCC_VER=$(GCC) .

buildnc:
	docker build --no-cache --squash \
		-t $(REPO):$(TAG) \
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
