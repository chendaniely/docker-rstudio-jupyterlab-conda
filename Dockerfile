# Use Miniforge3 as the base image
FROM condaforge/miniforge3

# Set environment variable to prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Add CRAN repository
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    dirmngr gnupg apt-transport-https ca-certificates software-properties-common

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && \
    add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/' && \
    apt-get update && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# Install RStudio Server
RUN apt-get update && apt-get install -y --no-install-recommends gdebi-core && \
    wget --no-verbose https://download2.rstudio.org/server/focal/amd64/rstudio-server-2023.12.0-369-amd64.deb && \
    gdebi -n rstudio-server-2023.12.0-369-amd64.deb && \
    rm rstudio-server-2023.12.0-369-amd64.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install R and set timezone to America
RUN apt-get update && \
    apt-get install -y --no-install-recommends r-base r-base-dev && \
    ln -fs /usr/share/zoneinfo/America /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Jupyter Lab
RUN conda install -y -c conda-forge jupyterlab && \
    #conda install -y -c conda-forge notebook && \
    #conda install -y -c conda-forge nb_conda_kernels && \
    conda clean -afy

# Create user and its home directory
RUN useradd -m -s /bin/bash rstudio

# Set the working directory to the home directory of the  user
WORKDIR /home/rstudio

# Change ownership of the home directory to the user
RUN chown -R rstudio:rstudio /home/rstudio

# Expose ports for RStudio Server and Jupyter Lab
EXPOSE 8787 8888

# Change root password
#RUN echo 'rstudio-server:pass' | chpasswd
RUN echo 'rstudio:pass' | chpasswd
RUN echo 'root:pass' | chpasswd

#USER rstudio

# Set up default command to run RStudio Server and Jupyter Lab
#CMD ["bash", "-c", "/usr/lib/rstudio-server/bin/rserver --auth-none=1 --server-daemonize=0  & jupyter lab --ip=0.0.0.0 --allow-root --no-browser --NotebookApp.token='' --NotebookApp.password=''"]
CMD ["bash", "-c", "/usr/lib/rstudio-server/bin/rserver --server-user=rstudio --server-daemonize=0  & jupyter lab --ip=0.0.0.0 --allow-root --no-browser --NotebookApp.token='' --NotebookApp.password=''"]
