
CLIB2REPO ?= adtools # or use afxgroup
REPO ?= walkero/amigagccondocker
TAG ?= ppc-amigaos-sdk
VOLUMES ?= 
WORKSPACE ?= -w /opt/code
NAME ?= ppc-amigaos-sdk
CLIB2TAG := 

ifeq ($(CLIB2REPO), afxgroup)
override CLIB2TAG = -newclib2
override TAG = ppc-amigaos-sdk$(CLIB2TAG)
endif

.PHONY: build buildnc shell push logs clean test release

default: build

build:
	docker build --squash \
		-t $(REPO):$(TAG) \
		--build-arg CLIB2_REPO=$(CLIB2REPO) .

buildnc:
	docker build --no-cache --squash \
		-t $(REPO):$(TAG) \
		--build-arg CLIB2_REPO=$(CLIB2REPO) .

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
