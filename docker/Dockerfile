# Use rocker R 4.4 base image
FROM rocker/r-ver:4.4.0

LABEL maintainer="Jing Cui"

ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C

# Install system dependencies for R packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff5-dev \
    pandoc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install R packages
RUN R -e "install.packages('remotes')"
RUN R -e "remotes::install_version(package = 'tidyverse',version = '1.3.1')"
RUN R -e "remotes::install_version('rmarkdown', version = '2.27')"
RUN R -e "remotes::install_version('knitr', version = '1.43')"
RUN R -e "remotes::install_version('DT', version = '0.33')"


HEALTHCHECK NONE

