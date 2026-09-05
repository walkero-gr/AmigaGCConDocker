include ../_common/help.mk

# Target architecture for the build
ARCH=ppc-amigaos

# GCC version to use
GCC?=11

# Release version
REL?=3.3.1

# GCC base image version to use
BASE_VER?=1.8.1

REPO=walkero/amigagccondocker
TAG=os4-gcc$(GCC)-$(REL)
VOLUMES=-v "${PWD}/tests":/opt/code
WORKSPACE=-w /opt/code
NAME=$(TAG)

#####################################################################
##@ Build dev environment

.PHONY: build
build: ## Build the main dev environment image
	docker buildx build -f ./Dockerfile \
		-t $(REPO):$(TAG) \
		--progress plain \
		--build-arg GCC_VER=$(GCC) \
		--build-arg BASE_VER=$(BASE_VER) \
		--build-arg REL_VER=$(REL) .

.PHONY: buildnc
buildnc: ## Build the main dev environment image with no-cache
	docker buildx build --no-cache -f ./Dockerfile \
		-t $(REPO):$(TAG) \
		--progress plain \
		--build-arg GCC_VER=$(GCC) \
		--build-arg BASE_VER=$(BASE_VER) \
		--build-arg REL_VER=$(REL) .

.PHONY: shell
shell: ## Create a container with the latest Docker image and use it
	docker run -it --rm --name $(TAG) $(VOLUMES) $(WORKSPACE) $(REPO):$(TAG) /bin/bash

#####################################################################
##@ Build SDK help image

.PHONY: build-sdk
build-sdk: ## Build the sdk-files image
	docker buildx build --no-cache -f ./Dockerfile.sdk \
		-t $(REPO):ppc-amigaos-sdk \
		--progress plain .

.PHONY: shell-sdk
shell-sdk: ## Create a container with the latest SDK Docker image and use it
	docker run -it --rm --name sdk $(REPO):ppc-amigaos-sdk /bin/bash

#####################################################################
##@ Helpers

.PHONY: push
push: ## Push the Docker image to the repository
	docker push $(REPO):$(TAG)

.PHONY: logs
logs: ## Show the logs of the container
	docker logs $(NAME)

.PHONY: clean
clean: ## Remove the container if it exists
	-docker rm -f $(NAME)

.PHONY: test
test: ## Test the Docker image with snyk
	snyk test --docker $(REPO):$(TAG) --file=Dockerfile

.PHONY: release
release: build push ## Build and push the Docker image
