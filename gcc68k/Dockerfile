ARG GCC_VER

FROM walkero/amigagccondocker:68k-base-gcc${GCC_VER} as adtools-image
FROM walkero/amigagccondocker:68k-amigaos-sdk as sdk-image
FROM walkero/lha-on-docker as lha-image
FROM phusion/baseimage:master

LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

ENV AMIDEV_USER_ID=1000
ENV AMIDEV_GROUP_ID=1000

ENV A68K="/opt/amiga" \
    SDK_PATH="/opt/sdk"

COPY --from=adtools-image ${A68K} ${A68K}
COPY --from=sdk-image ${SDK_PATH} ${SDK_PATH}
COPY --from=lha-image /usr/bin/lha /usr/bin/lha

RUN apt-get update && apt-get -y --no-install-recommends install \
    bison \
    cmake \
    cppcheck \
    curl \
    cvs \
    flawfinder \
    flex \
    git \
    gperf \
    libgmp-dev \
    libisl-dev \
    libmpc-dev \
    libmpfr-dev \
    make \
    mc \
    mercurial \
    meson \
    pkg-config \
    python \
    splint \
    ruby \
    subversion \
    sudo \
    wget; \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

# Add amidev user and group
RUN existing_group=$(getent group "${AMIDEV_GROUP_ID}" | cut -d: -f1); \
    if [[ -n "${existing_group}" ]]; then delgroup "${existing_group}"; fi; \
    existing_user=$(getent passwd "${AMIDEV_USER_ID}" | cut -d: -f1); \
    if [[ -n "${existing_user}" ]]; then deluser "${existing_user}"; fi; \
    addgroup --gid ${AMIDEV_GROUP_ID} amidev; \
    adduser --system --uid ${AMIDEV_USER_ID} --disabled-password --shell /bin/bash --gid ${AMIDEV_GROUP_ID} amidev; \
    sed -i '/^amidev/s/!/*/' /etc/shadow; 

ENV PATH="${A68K}/bin:$PATH" \
    AS=${A68K}/bin/m68k-amigaos-as \
    LD=${A68K}/bin/m68k-amigaos-ld \
    AR=${A68K}/bin/m68k-amigaos-ar \
    CC=${A68K}/bin/m68k-amigaos-gcc \
    CXX=${A68K}/bin/m68k-amigaos-g++ \
    RANLIB=${A68K}/bin/m68k-amigaos-ranlib

RUN ln -sf ${A68K}/bin/m68k-amigaos-as /usr/bin/as && \
    ln -sf ${A68K}/bin/m68k-amigaos-ar /usr/bin/ar && \
    ln -sf ${A68K}/bin/m68k-amigaos-ld /usr/bin/ld && \
    ln -sf ${A68K}/bin/m68k-amigaos-gcc /usr/bin/gcc && \
    ln -sf ${A68K}/bin/m68k-amigaos-g++ /usr/bin/g++ && \
    ln -sf ${A68K}/bin/m68k-amigaos-ranlib /usr/bin/ranlib;

RUN mkdir -p /opt/code;
    # \
    # rm -rf ${A68K}/m68k-amigaos/ndk-include; \
    # rm -rf ${A68K}/m68k-amigaos/ndk13-include; \
    # ln -s ${SDK_PATH}/NDK_3.9/Include/include_h ${A68K}/m68k-amigaos/ndk-include;

WORKDIR /tmp

# Install FlexCat
RUN curl -fsSL "https://github.com/adtools/flexcat/releases/download/2.18/FlexCat-2.18.lha" -o /tmp/FlexCat.lha && \
    lha -xfq2 FlexCat.lha && \
    cp ./FlexCat/Linux-i386/flexcat /usr/bin/ && \
    rm -rf /tmp/*;

# Setup ENV Variables
ENV NDK_INC="${A68K}/m68k-amigaos/ndk-include" \
    SDK_INC="${SDK_PATH}/include/include_h" \
    NET_INC="${SDK_PATH}/include/netinclude" \
    NLIB_INC="${SDK_PATH}/newlib/include" \
    CLIB_INC="${SDK_PATH}/clib2/include" \
    MUI50_INC="${SDK_PATH}/MUI_5.0/C/include" \
    MUI38_INC="${SDK_PATH}/MUI_3.8/C/Include" \
    SQLITE_INC="${SDK_PATH}/sqlite/include"

WORKDIR /opt/code

# Add git branch name to bash prompt
ARG BASHFILE=/home/amidev/.bashrc
RUN cp ~/.bashrc /home/amidev/; \
    chown amidev:amidev ${BASHFILE}; \
    sed -i '4c\'"\nparse_git_branch() {\n\
  git branch 2> /dev/null | sed -e \'/^[^*]/d\' -e \'s/* \\\(.*\\\)/ (\\\1)/\'\n\
}\n" ${BASHFILE}; \
    sed -i '43c\'"force_color_prompt=yes" ${BASHFILE}; \
    sed -i '57c\'"    PS1=\'\${debian_chroot:+(\$debian_chroot)}\\\[\\\033[01;32m\\\]\\\u@\\\h\\\[\\\033[00m\\\]:\\\[\\\033[01;34m\\\]\\\w\\\[\\\033[01;31m\\\]\$(parse_git_branch)\\\[\\\033[00m\\\]\\\$ '" ${BASHFILE}; \
    sed -i '59c\'"    PS1=\'\${debian_chroot:+(\$debian_chroot)}\\\u@\\\h:\\\w \$(parse_git_branch)\$ \'" ${BASHFILE}; \
    sed -i '3c\'"\nexport PATH=${PATH}\n" ${BASHFILE};

# Set PATH on amidev user
USER amidev

USER root
RUN chown amidev:amidev /opt -R
