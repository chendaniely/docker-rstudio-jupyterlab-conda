.PHONY: build
build:
	DOCKER_BUILDKIT=1 docker buildx build .


.PHONY: build_clean
build_clean:
	DOCKER_BUILDKIT=1 docker buildx build --no-cache .


.PHONY: run
run:
