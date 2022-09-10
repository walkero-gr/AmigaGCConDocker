ARG GCC_VER

FROM walkero/amigagccondocker:ppc-base-gcc${GCC_VER} as adtools-image
FROM walkero/amigagccondocker:ppc-amigaos-sdk as sdk-image
FROM walkero/lha-on-docker as lha-image
FROM phusion/baseimage:master

LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

ENV AMIDEV_USER_ID=1000
ENV AMIDEV_GROUP_ID=1000

ENV APPC="/opt/ppc-amigaos" \
    OS4_SDK_PATH="/opt/sdk/ppc-amigaos" \
    SDK_PATH="/opt/sdk"

COPY --from=adtools-image ${APPC} ${APPC}
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

ENV PATH="${APPC}/bin:$PATH" \
    AS=${APPC}/bin/ppc-amigaos-as \
    LD=${APPC}/bin/ppc-amigaos-ld \
    AR=${APPC}/bin/ppc-amigaos-ar \
    CC=${APPC}/bin/ppc-amigaos-gcc \
    CXX=${APPC}/bin/ppc-amigaos-g++ \
    RANLIB=${APPC}/bin/ppc-amigaos-ranlib

RUN ln -sf ${APPC}/bin/ppc-amigaos-as /usr/bin/as && \
    ln -sf ${APPC}/bin/ppc-amigaos-ar /usr/bin/ar && \
    ln -sf ${APPC}/bin/ppc-amigaos-ld /usr/bin/ld && \
    ln -sf ${APPC}/bin/ppc-amigaos-gcc /usr/bin/gcc && \
    ln -sf ${APPC}/bin/ppc-amigaos-g++ /usr/bin/g++ && \
    ln -sf ${APPC}/bin/ppc-amigaos-ranlib /usr/bin/ranlib;

RUN mkdir -p /opt/code; \
    rm -rf ${APPC}/ppc-amigaos/SDK; \
    ln -s /opt/sdk/ppc-amigaos/ ${APPC}/ppc-amigaos/SDK;

WORKDIR /tmp

# Install FlexCat
RUN curl -fsSL "https://github.com/adtools/flexcat/releases/download/2.18/FlexCat-2.18.lha" -o /tmp/FlexCat.lha && \
    lha -xfq2 FlexCat.lha && \
    cp ./FlexCat/Linux-i386/flexcat /usr/bin/ && \
    rm -rf /tmp/*;

# Setup ENV Variables
ENV AOS4_SDK_INC="${OS4_SDK_PATH}/include/include_h" \
    AOS4_NET_INC="${OS4_SDK_PATH}/include/netinclude" \
    AOS4_NLIB_INC="${OS4_SDK_PATH}/newlib/include" \
    AOS4_CLIB_INC="${OS4_SDK_PATH}/clib2/include" \
    MUI50_INC="/opt/sdk/MUI_5.0/C/include" 
    # \
    # SDL_INC="/opt/sdk/SDL/include" \
    # SDL_LIB="/opt/sdk/SDL/lib" \
    # SDL2_INC="/opt/sdk/SDL2/include" \
    # SDL2_LIB="/opt/sdk/SDL2/lib" \
    # OO_INC="/opt/sdk/OOLib/include"

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
