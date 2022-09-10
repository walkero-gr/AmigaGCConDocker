FROM walkero/lha-on-docker as lha-image

# The ubuntu:latest tag points to the "latest LTS", since that's the version recommended for general use.
FROM ubuntu:latest

LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"

ARG DEBIAN_FRONTEND=noninteractive
ARG GCC_VER
ARG NDK_VER
ARG REPOS_PATH
ARG FILES_PATH
COPY --from=lha-image /usr/bin/lha /usr/bin/lha

# Add necessary repos
ADD ${REPOS_PATH}/amiga-gcc /opt/amiga-gcc
WORKDIR /opt/amiga-gcc

# RUN dpkg --add-architecture i386 && apt-get update && apt-get -y --no-install-recommends install \
#     ca-certificates \
#     curl;
    # \
    # python2.7;

# RUN ln -s /usr/bin/python2.7 /usr/bin/python; \
#     curl -fsSL https://bootstrap.pypa.io/pip/2.7/get-pip.py -o /tmp/get-pip.py && \
#     python get-pip.py && \
#     pip2 install --no-cache-dir argcomplete==1.12.3; \
#     rm -rf /tmp/* /var/tmp/*;

# Get custom makefiles before we compile GCC
# COPY ${FILES_PATH}/native-build/makefile-SDK${NDK_VER} /opt/adtools/native-build/makefile

ENV PACKAGES="autoconf \
        automake \
        autopoint \
        bison \
        ca-certificates \
        curl \
        dh-autoreconf \
        flex \
        g++ \
        gettext \
        git \
        gperf \
        libfl2 \
        libgmp-dev \
        libmpc3 \
        libmpc-dev \
        libmpfr-dev \
        libtool \
        make \
        mc \
        nano \
        ncurses-dev \
        patch \
        rsync \
        texinfo \
        wget \
        xz-utils"

RUN apt-get update && \
    apt-get -y --no-install-recommends install ${PACKAGES}; \
    # Compile gcc \
    make update NDK=3.2 && \
    make all all-sdk -j4 NDK=3.2; \
    # Clean installed apps \
    rm -rf /opt/amiga-gcc; \
    apt -y remove ${PACKAGES}; \
    apt -y autoremove; \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /opt/adtools;




# For Jens Maus GCC 2
# RUN curl -fsSL "https://github.com/adtools/adtools/releases/download/20170213/adtools-m68k-amigaos.tar.bz2" -o /tmp/adtools.tar.bz2 && \
#     tar xf adtools.tar.bz2 && \
#     mv ./opt/m68k-amigaos /opt/m68k-amigaos && \
#     rm -rf /tmp/*