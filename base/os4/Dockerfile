
FROM alpine/git:2.40.1 AS git-clone

RUN mkdir /repos; \
    git clone https://github.com/sba1/adtools           /repos/adtools --depth 1; \
    git clone https://github.com/3246251196/adtools.git /repos/adtools-rjd324 --depth 1; \
    git clone https://github.com/bminor/binutils-gdb    /repos/binutils-gdb; \
    git clone https://github.com/coreutils/coreutils    /repos/coreutils; \
    git clone https://github.com/coreutils/gnulib       /repos/gnulib

# The ubuntu:latest tag points to the "latest LTS", since that's the version recommended for general use.
FROM ubuntu:latest AS builder

ARG DEBIAN_FRONTEND=noninteractive
ARG GCC_VER
ARG CLIB2_REPO
ARG CLIB2_SRC

ENV GCC_VER=${GCC_VER}
ENV CLIB2_REPO=${CLIB2_REPO}
ENV CLIB2_SRC=${CLIB2_SRC}

COPY --from=walkero/lha-on-docker /usr/bin/lha /usr/bin/lha

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
    gpg \
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

RUN apt-get update && \
    apt-get -y --no-install-recommends install ${PACKAGES}; \
    ln -s /usr/bin/g++-10 /usr/bin/g++; \
    rm /usr/bin/gcc; \
    ln -s /usr/bin/gcc-10 /usr/bin/gcc;

# Copy necessary repos from git-clone
COPY --from=git-clone /repos/adtools /opt/adtools
COPY --from=git-clone /repos/binutils-gdb /opt/adtools/binutils/repo
COPY --from=git-clone /repos/coreutils /opt/adtools/coreutils/repo
COPY --from=git-clone /repos/gnulib /opt/adtools/gnulib/repo
COPY misc /opt/misc

WORKDIR /opt/adtools

COPY scripts/compile-adtools.sh /compile-adtools.sh
RUN chmod +x /compile-adtools.sh && bash /compile-adtools.sh

# Clean up
RUN apt-get -y remove ${PACKAGES} \
        curl \
        python3; \
    apt-get -y autoremove; \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /opt/adtools;

FROM ubuntu:latest
LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"
COPY --from=builder /opt/ppc-amigaos /opt/ppc-amigaos
