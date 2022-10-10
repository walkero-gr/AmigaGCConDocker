GCC ?= 8 # 8,9,10,11 can be used here
CLIB2REPO ?= adtools # or use afxgroup
REPO ?= walkero/amigagccondocker
TAG ?= ppc-amigaos-gcc$(GCC)
VOLUMES ?= -v "${PWD}/code":/opt/code
WORKSPACE ?= -w /opt/code
NAME ?= ppc-amigaos-gcc$(GCC)
CLIB2TAG := 

ifeq ($(CLIB2REPO), afxgroup)
override CLIB2TAG = -newclib2
override TAG = ppc-amigaos-gcc$(GCC)$(CLIB2TAG)
endif

.PHONY: build buildnc shell push logs clean test release

default: build

build:
	docker build --squash \
		-t $(REPO):$(TAG) \
		--build-arg CLIB2_TAG=$(CLIB2TAG) \
		--build-arg GCC_VER=$(GCC) .

buildnc:
	docker build --no-cache --squash \
		-t $(REPO):$(TAG) \
		--build-arg CLIB2_TAG=$(CLIB2TAG) \
		--build-arg GCC_VER=$(GCC) .

shell:
	docker run -it --rm --name $(NAME)$(CLIB2TAG) $(VOLUMES) $(WORKSPACE) $(REPO):$(TAG) /bin/bash

push:
	docker push $(REPO):$(TAG)

logs:
	docker logs $(NAME)

clean:
	-docker rm -f $(NAME)

test:
	snyk test --docker $(REPO):$(TAG) --file=Dockerfile

release: build push
