GCC ?= 8
MAKEFILESPATH ?= files/native-build
REPO ?= walkero/amigagccondocker
TAG ?= ppc-base-gcc$(GCC)
WORKSPACE ?= -w /opt/code
NAME ?= ppc-base-gcc$(GCC)

.PHONY: build buildnc shell push logs clean test release

default: build

build:
	docker build -t $(REPO):$(TAG) \
		--build-arg GCC_VER=$(GCC) \
		--build-arg MAKEFILES_PATH=$(MAKEFILESPATH) .

buildnc:
	docker build --no-cache -t $(REPO):$(TAG) \
		--build-arg GCC_VER=$(GCC) \
		--build-arg MAKEFILES_PATH=$(MAKEFILESPATH) .

shell:
	docker run -it --rm --name $(NAME) $(WORKSPACE) $(REPO):$(TAG) /bin/bash

push:
	docker push $(REPO):$(TAG)

logs:
	docker logs $(NAME)

clean:
	-docker rm -f $(NAME)

test:
	snyk test --docker $(REPO):$(TAG) --file=Dockerfile

release: build push
