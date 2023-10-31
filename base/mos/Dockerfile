# The ubuntu:latest tag points to the "latest LTS", since that's the version recommended for general use.
FROM ubuntu:latest AS builder


# wget 'https://bigfoot.morphos-team.net/test/morphos-sdk_20230510-1_amd64.deb'
# apt-get install ./morphos-sdk_20230510-1_amd64.deb

ARG GCC_VER

COPY --from=walkero/lha-on-docker /usr/bin/lha /usr/bin/lha
ENV PATH="/gg/bin:$PATH"
COPY scripts/setup-cross-sdk.sh /setup-cross-sdk.sh
COPY files/* /tmp/

ENV PACKAGES="autoconf \
    automake \
    autopoint \
    bison \
    bzip2 \
    ca-certificates \
    curl \
    dh-autoreconf \
    flex \
    g++ \
    gettext \
    git \
    gperf \
    gpg \
    libfl2 \
    libgmp-dev \
    libmpc3 \
    libmpc-dev \
    libtool \
    make \
    patch \
    rsync \
    texinfo \
    wget \
    xz-utils"

RUN apt-get update && \
    apt-get -y --no-install-recommends install ${PACKAGES}; 

WORKDIR /tmp
RUN mkdir -p /gg/bin && \
    if [ ! -f "/tmp/sdk-source-20230510.tar.xz" ]; then \
        curl -fsSL "https://www.morphos-team.net/files/src/sdk/sdk-source-20230510.tar.xz" -o sdk-source-20230510.tar.xz; \
    fi; \
    if [ ! -f "/tmp/sdk-20230510.lha" ]; then \
        curl -fsSL "https://www.morphos-team.net/files/sdk-20230510.lha" -o sdk-20230510.lha; \
    fi; \
    chmod +x /setup-cross-sdk.sh && bash /setup-cross-sdk.sh --gcc${GCC_VER}


##############################################################################
# Final Base environment image
FROM ubuntu:latest
LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"
COPY --from=builder /gg /gg
