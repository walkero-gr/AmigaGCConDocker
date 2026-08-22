# Dev environment image
FROM phusion/baseimage:resolute
LABEL maintainer="Georgios Sokianos <walkero@gmail.com>" \
      org.opencontainers.image.title="MorphOS cross-compiling development environment" \
      org.opencontainers.image.description="MorphOS cross-compiling development environment" \
      org.opencontainers.image.source="https://github.com/walkero-gr/AmigaGCConDocker" \
      org.opencontainers.image.url="https://github.com/walkero-gr/AmigaGCConDocker" \
      org.opencontainers.image.vendor="walkero" \
      org.opencontainers.image.base.name="phusion/baseimage:resolute"

ARG DEBIAN_FRONTEND=noninteractive

COPY --from=walkero/lha-on-docker /usr/bin/lha /usr/bin/lha

ENV AMIDEV_USER_ID=1000 \
    AMIDEV_GROUP_ID=1000

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

# SDK found at https://morph.zone/modules/newbb_plus/viewtopic.php?forum=12&topic_id=13308
COPY scripts /scripts
RUN chmod +x /scripts/* -R; \
    bash /scripts/setup-user.sh ;\
    bash /scripts/setup-tools.sh ; \
    \
    dpkg --add-architecture amd64; \
    curl --retry 5 --retry-delay 2 --retry-connrefused \
        -fsSLk "https://bigfoot.morphos-team.net/test/morphos-sdk_20230510-1_amd64.deb" -o morphos-sdk_amd64.deb && \
    dpkg -i ./morphos-sdk_amd64.deb && \
    rm morphos-sdk_amd64.deb; \
    mkdir -p /gg/usr/local/; \
    \
    bash /scripts/install-libs.sh; \
    rm -rf /scripts

WORKDIR /opt/code

# Set PATH on amidev user
USER amidev

USER root
RUN chown ${AMIDEV_USER_ID}:${AMIDEV_GROUP_ID} /opt /gg -R 