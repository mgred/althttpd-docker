BUILD_ARGS=--network=host
ifdef TLS
	BUILD_ARGS+= --build-arg target=althttpsd
	NAME?=althttpsd
endif
ifneq ($(CHECKIN),)
	BUILD_ARGS+= --build-arg version=$(CHECKIN)
	TAG?=$(CHECKIN)
endif

NAME?=althttpd
TAG?=latest

DIR=$(PWD)
PORT=8080

build:
	docker build $(BUILD_ARGS) \
		--tag $(NAME):$(TAG) \
		.

run: build
	docker run --rm -it \
		--publish $(PORT):8080 \
		--volume $(DIR):/www \
		althttpd:latest

.PHONY: build run
