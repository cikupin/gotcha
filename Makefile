SHELL              = /bin/bash
APP_NAME           = gotcha
DOCKER_REGISTRY    = cikupin

.PHONY: default
default: help

.PHONY: help
help:
	@echo 'Make commands for ${APP_NAME}:'
	@echo
	@echo 'Usage:'
	@echo '    make build            Compile the project.'
	@echo '    make package          Build final Docker image with just the Go binary inside.'
	@echo '    make tag              Tag image created by package with latest, Git commit and version.'
	@echo '    make push             Push tagged images to registry.'
	@echo '    make run ARGS=        Run with supplied arguments.'
	@echo '    make test             Run tests on a compiled project.'
	@echo '    make clean            Clean the directory tree.'

	@echo

.PHONY: build
build:
	@echo "Building ${APP_NAME} ${VERSION}"
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags "-w" -o bin/${APP_NAME}

.PHONY: package
package: build
	@echo "Building  image ${APP_NAME} ${VERSION} ${GIT_COMMIT}"
	docker build -t ${DOCKER_REGISTRY}/${APP_NAME}:latest .

.PHONY: tag
tag: package
	@echo "Tagging: latest"
	docker tag ${DOCKER_REGISTRY}/${APP_NAME}:latest ${DOCKER_REGISTRY}/${APP_NAME}:latest

.PHONY: push
push: tag
	@echo "Pushing Docker image to registry: latest"
	docker push ${DOCKER_REGISTRY}/${APP_NAME}:latest

.PHONY: run
run: build
	@echo "Running ${APP_NAME}"
	bin/${APP_NAME}

.PHONY: clean
clean:
	@echo "Removing ${APP_NAME}"
	@test ! -e bin/${APP_NAME} || rm bin/${APP_NAME}