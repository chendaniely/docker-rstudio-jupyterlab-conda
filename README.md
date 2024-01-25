# docker-jupyter_rstudio
A docker container that has jupyter lab and rstudio server running

You can build the image with the `Makefile`:

```
# build the image
make build
```

Run the image and using the defualt ports for jupyter lab (8888) and rsudio (8787)

```
# run the image
make run
```

You should then be able to go to `localhost:8888` and `localhost:8787` in your browser to open up the applications.

If rstudio asks you for a username/password, try: `rstudio` and `pass`.
