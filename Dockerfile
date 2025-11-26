#
#   Dockerfile for multi-platform Quarto
#
#   Each stage self-contained to show dependencies clearly
#   and simplify customization. Hence the multiple apt-get
#   commands. 
#
ARG UBUNTU_VERSION=latest
ARG QUARTO_VERSION=1.8.26
#
#   Installer
#

# Quarto requires glibc, ubuntu much easier than alpine
FROM ubuntu:${UBUNTU_VERSION} as installer
ARG TARGETARCH
ARG TARGETOS
ARG QUARTO_VERSION
RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates \
  curl \
  dpkg \
  r-base-dev \
  && apt-get clean && rm -rf /var/lib/apt/lists/* \
  && curl -o quarto-${TARGETOS}-${TARGETARCH}.deb \
  -L https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-${TARGETOS}-${TARGETARCH}.deb \
  && dpkg --add-architecture ${TARGETARCH} \
  && dpkg --install quarto-${TARGETOS}-${TARGETARCH}.deb \
  && rm -f quarto-${TARGETOS}-${TARGETARCH}.deb

# Source - https://stackoverflow.com/a
# Posted by Ic3fr0g, modified by community. See post 'Timeline' for change history
# Retrieved 2025-11-12, License - CC BY-SA 4.0

RUN R -e "install.packages(c('knitr', 'rmarkdown'), dependencies=TRUE, repos='http://cran.rstudio.com/')"

# @TODO? from the installer we only need the folders where docker was installed
# we don't need ca-certificates, curl, dpkg. But we need the symlinks and PATH.

# 
#   Application
#
FROM installer
# install make for tests
RUN apt-get update && apt-get install -y --no-install-recommends \
  make \
  && apt-get clean && rm -rf /var/lib/apt/lists/*
WORKDIR /data
#ENTRYPOINT [ "quarto" ]
