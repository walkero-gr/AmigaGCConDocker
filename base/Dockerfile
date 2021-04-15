FROM phusion/baseimage:master-amd64

LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-get update && apt-get -y --no-install-recommends install \
    g++-10 \
    flex \
    git \
    lhasa \
    libfl2 \
    libgmp-dev \
    libmpc3 \
    libmpc-dev \
    libtool \
    make \
    python2.7 \
    texinfo \
    wget ; \
    ln -s /usr/bin/python2.7 /usr/bin/python; \
    ln -s /usr/bin/g++-10 /usr/bin/g++; \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

WORKDIR /tmp

# Install python2 pip
RUN cd /tmp; \
    curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py; \
    python get-pip.py; \
    pip2 install --no-cache-dir argcomplete; \
    rm -rf /tmp/*;

# Fix for the AmigaOS SDK download
ARG MAKEFILES_PATH
COPY ${MAKEFILES_PATH} /opt/temp/native-build

WORKDIR /opt
ARG GCC_VER

# Compile adtools ppc-amigaos-gcc
RUN git config --global user.email "walkero@gmail.com"; \
    git config --global user.name "Georgios Sokianos"; \
    if [ ${GCC_VER} -eq 10 ] ; \
    then \
        git clone https://github.com/sodero/adtools -b topic/gcc10_support; \
    else \
        git clone https://github.com/sba1/adtools; \
    fi; \
    cd /opt/adtools || exit; \
    git submodule init; \
    git submodule update; \
    gild/bin/gild clone; \
    gild/bin/gild checkout binutils 2.23.2; \
    gild/bin/gild checkout gcc ${GCC_VER}; \
    cp /opt/temp/native-build/makefile-${GCC_VER} /opt/adtools/native-build/; \
    make -C native-build gcc-cross CROSS_PREFIX=/opt/ppc-amigaos -j4; \
    cd /opt || exit; \
    rm -rf /opt/adtools;
