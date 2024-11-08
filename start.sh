#!/bin/bash

# Start Jupyter Lab as coder
su - coder -s /bin/bash -c 'nohup /home/coder/miniforge3/bin/jupyter lab --ip=0.0.0.0 --no-browser --allow-root --NotebookApp.token="" &' &
# Start RStudio Server
rstudio-server start

# list active sessions
rstudio-server active-sessions

# Keep the container running
tail -f /dev/null
