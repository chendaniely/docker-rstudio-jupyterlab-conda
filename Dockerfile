# Base image for R and RStudio Server
FROM rocker/verse:latest

# Install dependencies and Miniforge3
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    sudo \
    bzip2 \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && apt-get clean

# Create a unified user for Jupyter and RStudio Server
RUN useradd -m coder && echo "coder:pass" | chpasswd && adduser coder sudo

# Set the working directory to the unified user's home
WORKDIR /home/coder

# Install Miniforge3 for Conda
RUN wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh -O Miniforge3.sh && \
    bash Miniforge3.sh -b -p /home/coder/miniforge3 && \
    rm Miniforge3.sh

# Update PATH environment variable for Conda
ENV PATH="/home/coder/miniforge3/bin:$PATH"

ENV SHELL=/bin/bash

# Base environment install
RUN conda install -y jupyterlab conda-lock && \
    conda clean --all -y

# Expose ports for RStudio Server (8787) and JupyterLab (8888)
EXPOSE 8787 8888

# Add a script to run both services
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# add rc scripts
COPY .bash_profile .bash_profile
COPY .bashrc .bashrc

RUN chown -R coder:coder /home/coder/miniforge3

# Start Jupyter Lab and RStudio Server
CMD ["/usr/local/bin/start.sh"]
