APP       = simplecv
BUILD     = $(shell git describe --tags `git rev-list --tags --max-count=1`)
APP_IMAGE = $(APP):$(BUILD)

export APP_IMAGE
export BUILD

build:
	docker build --tag $(APP_IMAGE) --label "version=$(BUILD)" .

dev: build
	docker run --rm -it -v $$PWD/src:/app $(APP_IMAGE) bash

test: build
	docker run --rm $(APP_IMAGE) rspec
