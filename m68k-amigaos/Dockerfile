##############################################################################
# adtools image
ARG GCC_VER=6
ARG BASE_VER=1.0.0

FROM walkero/amigagccondocker:m68k-gcc${GCC_VER}-base-${BASE_VER} AS adtools-image

##############################################################################
# Dev environment image
FROM phusion/baseimage:resolute
LABEL maintainer="Georgios Sokianos <walkero@gmail.com>" \
      org.opencontainers.image.title="AmigaOS 3 m68k cross-compiling development environment" \
      org.opencontainers.image.description="AmigaOS 3 m68k cross-compiling development environment" \
      org.opencontainers.image.source="https://github.com/walkero-gr/AmigaGCConDocker" \
      org.opencontainers.image.url="https://github.com/walkero-gr/AmigaGCConDocker" \
      org.opencontainers.image.vendor="walkero" \
      org.opencontainers.image.base.name="phusion/baseimage:resolute"

ARG REL_VER=1.0.0
LABEL version=$REL_VER

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

ENV CCRED="\033[31m" \
    CCGREEN="\033[32m" \
    CCYELLOW="\033[33m" \
    CCBLUE="\033[34m" \
    CCPINK="\033[35m" \
    CCLBLUE="\033[36m" \
    CCEND="\033[0m" \
    CCBOLD="\033[1m" \
    CCITAL="\033[3m" \
    CCUNDR="\033[4m"

ENV AMIDEV_USER_ID=1000 \
    AMIDEV_GROUP_ID=1000 \
    APPC="/opt/m68k-amigaos" \
    PATH="/opt/m68k-amigaos/bin:$PATH" \
    SDK_PATH="/opt/m68k-amigaos/m68k-amigaos"

ENV AS=${APPC}/bin/m68k-amigaos-as \
    LD=${APPC}/bin/m68k-amigaos-ld \
    AR=${APPC}/bin/m68k-amigaos-ar \
    CC=${APPC}/bin/m68k-amigaos-gcc \
    CXX=${APPC}/bin/m68k-amigaos-g++ \
    RANLIB=${APPC}/bin/m68k-amigaos-ranlib

COPY --from=walkero/lha-on-docker /usr/bin/lha /usr/bin/lha
COPY --from=adtools-image /opt/m68k-amigaos /opt/m68k-amigaos
COPY --from=walkero/amigagccondocker:m68k-amigaos-sdk /opt/m68k-amigaos /opt/m68k-amigaos

# RUN ln -sf ${APPC}/bin/ppc-amigaos-as /usr/bin/as && \
#     ln -sf ${APPC}/bin/ppc-amigaos-ar /usr/bin/ar && \
#     ln -sf ${APPC}/bin/ppc-amigaos-ld /usr/bin/ld && \
#     ln -sf ${APPC}/bin/ppc-amigaos-gcc /usr/bin/gcc && \
#     ln -sf ${APPC}/bin/ppc-amigaos-g++ /usr/bin/g++ && \
#     ln -sf ${APPC}/bin/ppc-amigaos-ranlib /usr/bin/ranlib

COPY scripts/setup-user.sh /setup-user.sh
COPY scripts/setup-tools.sh /setup-tools.sh

RUN chmod +x /setup-user.sh /setup-tools.sh; \
    bash /setup-user.sh && rm /setup-user.sh; \
    bash /setup-tools.sh && rm /setup-tools.sh; \
    chown ${AMIDEV_USER_ID}:${AMIDEV_GROUP_ID} /opt -R

WORKDIR /opt/code
