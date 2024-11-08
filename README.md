# Docker with RStudio and Jupyter Lab via Conda

A docker container that has RStudio Server and Jupyter Lab.

You can build the image with the `Makefile`:

```bash
# build the image
make build

# build the image without cache
make build_clean
```

Run the image and using the default ports for jupyter lab (8888) and rstudio (8787)

```bash
# run the image
make run
```

This runs the container with the `rstudio_lab` name.
If you stop the container you will need to release the name.
You can do this with

```bash
make stop
```

There's also a `restart` target that runs the `stop` and `run` targets

```bash
make restart
```

You should then be able to go to `localhost:8888` and `localhost:8787` in your browser to open up the applications.

If rstudio asks you for a username/password, try: `coder` and `pass`.
