#!/bin/bash

# Start Jupyter Lab as unified_user
su unified_user -c 'nohup jupyter lab --ip=0.0.0.0 --no-browser --allow-root &' &

# Start RStudio Server
rstudio-server start

# list active sessions
rstudio-server active-sessions

# Keep the container running
tail -f /dev/null
