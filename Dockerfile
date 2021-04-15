ARG GCC_VER

FROM walkero/amigagccondocker:ppc-base-gcc${GCC_VER} as adtools-image
FROM walkero/amigagccondocker:ppc-amigaos-sdks as sdk-image
FROM walkero/docker4amigavbcc:latest-base

LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Remove from vbcc base image unused files
RUN rm -rf /opt/vbcc;

ENV APPC="/opt/ppc-amigaos" \
    OS4_SDK_PATH="/opt/sdk/ppc-amigaos" \
    SDKS_PATH="/opt/sdk"

COPY --from=adtools-image ${APPC} ${APPC}
COPY --from=sdk-image ${SDKS_PATH} ${SDKS_PATH}

RUN apt-get update && apt-get -y --no-install-recommends install \
    bison \
    cmake \
    cvs \
    flex \
    gperf \
    libgmp-dev \
    libisl-dev \
    libmpc-dev \
    libmpfr-dev \
    mercurial \
    pkg-config \
    python \
    ruby \
    subversion ; \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;


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

RUN mkdir -p /opt/code;

WORKDIR /tmp

# Setup ENV Variables
RUN rm -rf ${APPC}/ppc-amigaos/SDK; \
    ln -s /opt/sdk/ppc-amigaos/ ${APPC}/ppc-amigaos/SDK;

ENV AOS4_SDK_INC="${OS4_SDK_PATH}/Include/include_h" \
    AOS4_NET_INC="${OS4_SDK_PATH}/Include/netinclude" \
    AOS4_NLIB_INC="${OS4_SDK_PATH}/newlib/include" \
    AOS4_CLIB_INC="${OS4_SDK_PATH}/clib2/include" \
    MUI50_INC="/opt/sdk/MUI_5.0/C/include" \
    SDL_INC="/opt/sdk/SDL/include" \
    SDL_LIB="/opt/sdk/SDL/lib" \
    SDL2_INC="/opt/sdk/SDL2/include" \
    SDL2_LIB="/opt/sdk/SDL2/lib"

WORKDIR /opt/code

# Set PATH on amidev user
USER amidev
ARG BASHFILE=/home/amidev/.bashrc
RUN sed -i '4c\'"\nexport PATH=${PATH}\n" ${BASHFILE};

USER root
RUN chown amidev:amidev /opt -R
