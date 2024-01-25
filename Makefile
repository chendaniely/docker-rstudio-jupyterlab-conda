@PHONY: build
build:
	docker build -t jupyter_rstudio .

@PHONY: run
run:
	docker run -p 8888:8888 -p 8787:8787 -e PASSWORD=pass jupyter_rstudio

@PHONY: it
it:
	docker run -it -p 8888:8888 -p 8787:8787 -e PASSWORD=pass jupyter_rstudio /bin/bash

@PHONY: buildrstudio
buildrstudio:
	docker build -f rstudio -t rstudio .

@PHONY: runrstudio
runrstudio:
	docker run -p 8787:8787 rstudio
