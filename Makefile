.PHONY: build
build:
	DOCKER_BUILDKIT=1 docker buildx build -t rstudio_lab .


.PHONY: build_clean
build_clean:
	DOCKER_BUILDKIT=1 docker buildx build -t rstudio_lab --no-cache .


.PHONY: run
run:
	docker run -p 8888:8888 -p 8787:8787 -e PASSWORD=password -e DISABLE_AUTH=true --name rstudio_lab rstudio_lab

.PHONY: it
it:
	docker run -it -p 8888:8888 -p 8787:8787 -e PASSWORD=password rstudio_lab /bin/bash

.PHONY: stop
stop:
	docker stop rstudio_lab
	docker rm rstudio_lab

.PHONY: restart
restart:
	make stop && make run

.PHONY: push
push:
	docker tag rstudio_lab:latest chendaniely/rstudio_lab:latest
	docker push chendaniely/rstudio_lab:latest

.PHONY: build_mds
build_mds:
	DOCKER_BUILDKIT=1 docker buildx build -t mds_base --file Dockerfile-mds .

.PHONY: run_mds
run_mds:
	docker run -p 8888:8888 -p 8787:8787 -e PASSWORD=password -e DISABLE_AUTH=true --name mds_base mds_base

.PHONY: stop_mds
stop_mds:
	docker stop mds_base
	docker rm mds_base
