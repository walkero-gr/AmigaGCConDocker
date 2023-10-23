# The ubuntu:latest tag points to the "latest LTS", since that's the version recommended for general use.

##############################################################################
# adtools image
FROM walkero/amigagccondocker:os3-base-gcc as adtools-image


##############################################################################
# SDK Setup image
FROM ubuntu:latest AS sdk-builder

# ARG DEBIAN_FRONTEND=noninteractive
ARG CLIB2_REPO
ENV CLIB2_REPO=${CLIB2_REPO}

COPY --from=walkero/lha-on-docker /usr/bin/lha /usr/bin/lha

COPY scripts/os3.setup-sdk.sh /setup-sdk.sh
RUN chmod +x /setup-sdk.sh && bash /setup-sdk.sh


##############################################################################
# Dev environment image
FROM phusion/baseimage:jammy-1.0.1
LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

ENV AMIDEV_USER_ID=1000 \
    AMIDEV_GROUP_ID=1000 \
    APPC="/opt/m68k-amigaos" \
    PATH="/opt/amiga/bin:$PATH" \
    SDK_PATH="/opt/sdk/m68k-amigaos" \
    MUI50_INC="/opt/sdk/MUI_5.0/C/include"

# ENV AS=${APPC}/bin/m68k-amiga-elf-as \
#     LD=${APPC}/bin/m68k-amiga-elf-ld \
#     CC=${APPC}/bin/m68k-amiga-elf-gcc

COPY --from=walkero/lha-on-docker /usr/bin/lha /usr/bin/lha
COPY --from=sdk-builder /opt/sdk /opt/sdk
# COPY --from=adtools-image /opt/m68k-amigaos /opt/m68k-amigaos
COPY --from=stefanreinauer/amiga-gcc /opt/amiga /opt/amiga

# RUN ln -sf ${APPC}/bin/m68k-amiga-elf-as /usr/bin/as && \
#     ln -sf ${APPC}/bin/m68k-amiga-elf-ld /usr/bin/ld && \
#     ln -sf ${APPC}/bin/m68k-amiga-elf-gcc /usr/bin/gcc

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
