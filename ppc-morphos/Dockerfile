##############################################################################
# adtools image
ARG GCC_VER=11
ARG BASE_VER=1.0.0

FROM walkero/amigagccondocker:mos-gcc${GCC_VER}-base-${BASE_VER} AS gcc-base-image

##############################################################################
# Dev environment image
FROM phusion/baseimage:resolute
LABEL maintainer="Georgios Sokianos <walkero@gmail.com>" \
      org.opencontainers.image.title="MorphOS cross-compiling development environment" \
      org.opencontainers.image.description="MorphOS cross-compiling development environment" \
      org.opencontainers.image.source="https://github.com/walkero-gr/AmigaGCConDocker" \
      org.opencontainers.image.url="https://github.com/walkero-gr/AmigaGCConDocker" \
      org.opencontainers.image.vendor="walkero" \
      org.opencontainers.image.base.name="phusion/baseimage:resolute"

ARG REL_VER=1.1.0
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
    PATH="/gg/bin:$PATH" \
    SDK_PATH="/gg"

COPY --from=walkero/lha-on-docker /usr/bin/lha /usr/bin/lha
COPY --from=gcc-base-image /gg /gg
COPY --from=walkero/amigagccondocker:ppc-morphos-sdk /gg /gg

COPY scripts/setup-user.sh /setup-user.sh
COPY scripts/setup-tools.sh /setup-tools.sh

RUN chmod +x /setup-user.sh /setup-tools.sh; \
    bash /setup-user.sh && rm /setup-user.sh; \
    bash /setup-tools.sh && rm /setup-tools.sh; \
    chown ${AMIDEV_USER_ID}:${AMIDEV_GROUP_ID} /opt /gg -R

WORKDIR /opt/code





# COPY scripts /scripts
# RUN chmod +x /scripts/* -R; \
#     /scripts/setup-user.sh ;\
#     /scripts/setup-tools.sh ; \
#     \
#     /scripts/install-libs.sh; \
#     rm -rf /scripts
#
# WORKDIR /opt/code
#
# # Set PATH on amidev user
# USER amidev
#
# USER root
# RUN chown ${AMIDEV_USER_ID}:${AMIDEV_GROUP_ID} /opt /gg -R
