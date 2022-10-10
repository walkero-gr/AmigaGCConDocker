FROM walkero/lha-on-docker as lha-image

# The ubuntu:latest tag points to the "latest LTS", since that's the version recommended for general use.
FROM ubuntu:latest

LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"

ARG DEBIAN_FRONTEND=noninteractive
ARG GCC_VER
ARG SDK_VER
ARG REPOS_PATH
ARG FILES_PATH
ARG CLIB2_REPO
WORKDIR /tmp
COPY --from=lha-image /usr/bin/lha /usr/bin/lha

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

# Add necessary repos
ADD ${REPOS_PATH}/adtools /opt/adtools
ADD ${REPOS_PATH}/binutils-gdb /opt/adtools/binutils/repo
ADD ${REPOS_PATH}/coreutils /opt/adtools/coreutils/repo
ADD ${REPOS_PATH}/gnulib /opt/adtools/gnulib/repo
ADD ${REPOS_PATH}/misc /opt/misc

# Get custom makefiles before we compile GCC
COPY ${FILES_PATH}/native-build/makefile /opt/adtools/native-build/makefile

# Compile gcc
WORKDIR /opt/adtools
RUN git config --global user.email "walkero@gmail.com"; \
    git config --global user.name "Georgios Sokianos"; \
    git submodule init && \
    git submodule update && \
    gild/bin/gild checkout binutils 2.23.2 && \
    gild/bin/gild checkout gcc ${GCC_VER}

RUN make -C native-build gcc-cross CROSS_PREFIX=/opt/ppc-amigaos \
    CLIB2_REPO=${CLIB2_REPO} SDK_VERSION=${SDK_VER} -j4; \
    apt-get -y remove ${PACKAGES} \
        curl \
        python2.7; \
    apt-get -y autoremove; \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /opt/adtools /opt/misc;
