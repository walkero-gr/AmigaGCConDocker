# The ubuntu:latest tag points to the "latest LTS", since that's the version recommended for general use.

##############################################################################
# adtools image
ARG OS
ARG GCC_VER
ARG CLIB2_REPO

FROM walkero/amigagccondocker:${OS}-base-gcc${GCC_VER} as adtools-image


##############################################################################
# SDK Setup image
FROM ubuntu:latest AS sdk-builder

# ARG CLIB2_REPO
# ENV CLIB2_REPO=${CLIB2_REPO}
# ENV OS4_SDK_PATH="/opt/ppc-amigaos/ppc-amigaos/SDK"

# COPY --from=walkero/lha-on-docker /usr/bin/lha /usr/bin/lha
COPY --from=adtools-image /gg /gg

# COPY scripts/os4.setup-sdk.sh /scripts/setup-sdk.sh
# COPY scripts/libs /scripts/libs
# RUN chmod +x /scripts/* -R && bash /scripts/setup-sdk.sh


##############################################################################
# Dev environment image
FROM phusion/baseimage:jammy-1.0.1
LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

ENV AMIDEV_USER_ID=1000 \
    AMIDEV_GROUP_ID=1000 \
    PATH="/gg/bin:$PATH"
    # \
    # APPC="/opt/ppc-amigaos" \
    # PATH="/opt/ppc-amigaos/bin:$PATH" \
    # SDK_PATH="/opt/ppc-amigaos/ppc-amigaos/SDK" \
    # MUI50_INC="/opt/ppc-amigaos/ppc-amigaos/SDK/MUI_5.0/C/include"

# ENV AS=${APPC}/bin/ppc-amigaos-as \
#     LD=${APPC}/bin/ppc-amigaos-ld \
#     AR=${APPC}/bin/ppc-amigaos-ar \
#     CC=${APPC}/bin/ppc-amigaos-gcc \
#     CXX=${APPC}/bin/ppc-amigaos-g++ \
#     RANLIB=${APPC}/bin/ppc-amigaos-ranlib

COPY --from=walkero/lha-on-docker /usr/bin/lha /usr/bin/lha
COPY --from=sdk-builder /gg /gg

# RUN ln -sf ${APPC}/bin/ppc-amigaos-as /usr/bin/as && \
#     ln -sf ${APPC}/bin/ppc-amigaos-ar /usr/bin/ar && \
#     ln -sf ${APPC}/bin/ppc-amigaos-ld /usr/bin/ld && \
#     ln -sf ${APPC}/bin/ppc-amigaos-gcc /usr/bin/gcc && \
#     ln -sf ${APPC}/bin/ppc-amigaos-g++ /usr/bin/g++ && \
#     ln -sf ${APPC}/bin/ppc-amigaos-ranlib /usr/bin/ranlib;

COPY scripts/setup-user.sh /setup-user.sh
COPY scripts/setup-tools.sh /setup-tools.sh

RUN chmod +x /setup-user.sh /setup-tools.sh; \
    bash /setup-user.sh && rm /setup-user.sh; \
    bash /setup-tools.sh && rm /setup-tools.sh

WORKDIR /opt/code

# Set PATH on amidev user
USER amidev

USER root
RUN chown ${AMIDEV_USER_ID}:${AMIDEV_GROUP_ID} /opt /gg -R
