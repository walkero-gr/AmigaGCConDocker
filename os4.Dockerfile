# The ubuntu:latest tag points to the "latest LTS", since that's the version recommended for general use.

##############################################################################
# adtools image
ARG OS
ARG GCC_VER
ARG CLIB2_REPO

FROM walkero/amigagccondocker:${OS}-base-gcc${GCC_VER}-${CLIB2_REPO} as adtools-image


##############################################################################
# SDK Setup image
FROM ubuntu:latest AS sdk-builder

# ARG DEBIAN_FRONTEND=noninteractive
ARG CLIB2_REPO
ENV CLIB2_REPO=${CLIB2_REPO}

COPY --from=walkero/lha-on-docker /usr/bin/lha /usr/bin/lha

COPY scripts/os4.setup-sdk.sh /setup-sdk.sh
RUN chmod +x /setup-sdk.sh && bash /setup-sdk.sh


##############################################################################
# Dev environment image
FROM phusion/baseimage:jammy-1.0.1
LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

ENV AMIDEV_USER_ID=1000 \
    AMIDEV_GROUP_ID=1000 \
    APPC="/opt/ppc-amigaos" \
    PATH="/opt/ppc-amigaos/bin:$PATH" \
    SDK_PATH="/opt/sdk/ppc-amigaos" \
    MUI50_INC="/opt/sdk/MUI_5.0/C/include"

COPY --from=walkero/lha-on-docker /usr/bin/lha /usr/bin/lha
COPY --from=sdk-builder /opt/sdk /opt/sdk
COPY --from=adtools-image /opt/ppc-amigaos /opt/ppc-amigaos

COPY scripts/setup-user.sh /setup-user.sh
COPY scripts/setup-tools.sh /setup-tools.sh

RUN chmod +x /setup-user.sh /setup-tools.sh; \
    bash /setup-user.sh && rm /setup-user.sh; \
    bash /setup-tools.sh && rm /setup-tools.sh

WORKDIR /opt/code

# Set PATH on amidev user
USER amidev

USER root
RUN chown ${AMIDEV_USER_ID}:${AMIDEV_GROUP_ID} /opt -R
