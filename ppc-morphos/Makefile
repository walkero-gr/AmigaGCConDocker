
include ../_common/help.mk

OS?=ppc-morphos
REL?=1.1.0

REPO=walkero/amigagccondocker
TAG?=$(OS)-$(REL)
VOLUMES?=-v "${PWD}/out":/opt/out
WORKSPACE=-w /opt/code
NAME=$(TAG)
ARCH=ppc-morphos

#####################################################################
##@ Build dev environment

.PHONY: build
build: ## Build the main dev environment image
	docker buildx build -f ./Dockerfile \
		-t $(REPO):$(TAG) \
		--progress plain .

.PHONY: buildnc
buildnc: ## Build the main dev environment image with no-cache
	docker buildx build --no-cache -f ./Dockerfile \
		-t $(REPO):$(TAG) \
		--progress plain .

.PHONY: shell
shell: ## Create a container with the latest Docker image and use it
	docker run -it --rm --name $(NAME) $(VOLUMES) $(WORKSPACE) $(REPO):$(TAG) /bin/bash

#####################################################################
##@ Build SDK help image

.PHONY: build-sdk
build-sdk: ## Build the sdk-files image
	docker buildx build --no-cache -f ./Dockerfile.sdk \
		-t $(REPO):$(ARCH)-sdk \
		--progress plain .

.PHONY: shell-sdk
shell-sdk: ## Create a container with the latest SDK Docker image and use it
	docker run -it --rm --name sdk $(REPO):$(ARCH)-sdk /bin/bash

# push:
# 	docker push $(REPO):$(TAG)

# logs:
# 	docker logs $(NAME)

# clean:
# 	-docker rm -f $(NAME)

# test:
# 	snyk test --docker $(REPO):$(TAG) --file=Dockerfile

# release: build push
