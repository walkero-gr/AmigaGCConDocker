
# The ubuntu:latest tag points to the "latest LTS", since that's the version recommended for general use.
FROM ubuntu:latest AS builder

ARG DEBIAN_FRONTEND=noninteractive

COPY --from=walkero/lha-on-docker /usr/bin/lha /usr/bin/lha

ARG FILES_PATH

ENV PACKAGES="autoconf \
    automake \
    autopoint \
    bison \
    ca-certificates \
    curl \
    dh-autoreconf \
    flex \
    g++-10 \
    gettext \
    git \
    gperf \
    libfl2 \
    libgmp-dev \
    libmpc3 \
    libmpc-dev \
    libtool \
    make \
    mc \
    nano \
    patch \
    python3 \
    rsync \
    texinfo \
    wget \
    xz-utils"

RUN dpkg --add-architecture i386 && apt-get update && \
    apt-get -y --no-install-recommends install ${PACKAGES}; \
    ln -s /usr/bin/g++-10 /usr/bin/g++; \
    rm /usr/bin/gcc; \
    ln -s /usr/bin/gcc-10 /usr/bin/gcc;

COPY ${FILES_PATH}/* /opt/misc/

WORKDIR /opt/adtools
RUN git config --global user.email "walkero@gmail.com"; \
    git config --global user.name "Georgios Sokianos"; \
    git clone https://github.com/3246251196/adtools_testing.git . && \
        \cp /opt/misc/adtools_mod ./ 
#         && \
#         ./adt -b -e beta10 -o /opt/ppc-amigaos/ -m adtools_mod && \
#         ./adt -x -t;

# FROM ubuntu:latest
# LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"
# COPY --from=builder /opt/ppc-amigaos /opt/ppc-amigaos
