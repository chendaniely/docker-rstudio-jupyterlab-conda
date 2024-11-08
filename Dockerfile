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


# Install Miniforge3 for Conda
RUN wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh -O Miniforge3.sh && \
    bash Miniforge3.sh -b -p /opt/conda && \
    rm Miniforge3.sh

# Update PATH environment variable for Conda
ENV PATH="/opt/conda/bin:$PATH"

# Install JupyterLab
RUN conda install -y jupyterlab && \
    conda clean --all -y

# Create a unified user for Jupyter and RStudio Server
RUN useradd -m unified_user && echo "unified_user:unified_pass" | chpasswd && adduser unified_user sudo

# Set the working directory to the unified user's home
WORKDIR /home/unified_user

# Expose ports for RStudio Server (8787) and JupyterLab (8888)
EXPOSE 8787 8888

# Add a script to run both services
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Start Jupyter Lab and RStudio Server
CMD ["/usr/local/bin/start.sh"]
