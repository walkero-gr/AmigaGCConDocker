FROM ubuntu:20.10

LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"

RUN apt-get update && apt-get -y --no-install-recommends install \
    ca-certificates \
    curl \
    lhasa; \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

ENV APPC="/opt/ppc-amigaos" \
    OS4_SDK_PATH="/opt/sdk/ppc-amigaos"

RUN mkdir -p ${OS4_SDK_PATH};

WORKDIR /tmp

# Install AmigaOS 4 SDK
RUN curl -fskSL "https://www.hyperion-entertainment.com/index.php?option=com_registration&amp;view=download&amp;format=raw&amp;file=82&amp;Itemid=82" -o /tmp/AmigaOS4-SDK.lha && \
    lha -xfq2 AmigaOS4-SDK.lha; \
    # cd SDK_Install || exit; \
    lha -xfq2w=${OS4_SDK_PATH} SDK_Install/clib2*.lha; \
    lha -xfq2w=${OS4_SDK_PATH} SDK_Install/newlib*.lha; \
    lha -xfq2w=${OS4_SDK_PATH} SDK_Install/base.lha; \
    lha -xfq2w=${OS4_SDK_PATH} SDK_Install/pthreads*.lha; \
    lha -xfq2w=${OS4_SDK_PATH} SDK_Install/SDI-*.lha; \
    lha -xfq2w=${OS4_SDK_PATH} SDK_Install/cairo-*.lha; \
    lha -xfq2w=${OS4_SDK_PATH} SDK_Install/expat-*.lha; \
    mv /opt/sdk/ppc-amigaos/Include/ /opt/sdk/ppc-amigaos/include/; \
    cp -r /opt/sdk/ppc-amigaos/Local/* ${OS4_SDK_PATH}/; \
    cp -r /opt/sdk/ppc-amigaos/common/include/* ${OS4_SDK_PATH}/include/include_h/; \
    rm -rf  ${OS4_SDK_PATH}/C ${OS4_SDK_PATH}/Data ${OS4_SDK_PATH}/S \
            ${OS4_SDK_PATH}/AmigaOS\ 4.1\ SDK.pdf ${OS4_SDK_PATH}/AmigaOS\ 4.1\ SDK.pdf.info \
            ${OS4_SDK_PATH}/Docume/opt/sdk/ppc-amigaosntation.info ${OS4_SDK_PATH}/Local ${OS4_SDK_PATH}/common; \
    rm -rf /tmp/*;

# WORKDIR /tmp

# Install MUI 5.0 dev
RUN curl -fsSL "https://muidev.de/download/MUI%205.0%20-%20Release/MUI-5.0-2020R3-os4.lha" -o /tmp/MUI-5.0.lha; \
    curl -fsSL "https://muidev.de/download/MUI%205.0%20-%20Release/MUI-5.0-2020R3-os4-contrib.lha" -o /tmp/MUI-5.0-contrib.lha; \
    lha -xfq2 MUI-5.0.lha; \
    lha -xfq2 MUI-5.0-contrib.lha; \
    mv ./SDK/MUI /opt/sdk/MUI_5.0; \
    rm -rf /tmp/*;

# Install SDL SDK
RUN curl -fsSL "https://github.com/AmigaPorts/SDL/releases/download/v1.2.16-rc2-amigaos4/SDL.lha" -o /tmp/SDL.lha; \
    lha -xfq2 SDL.lha; \
    mv ./SDL/SDK/local/newlib /opt/sdk/SDL; \
    rm -rf /tmp/*;

# Install SDL 2 SDK
RUN curl -fsSL "https://github.com/AmigaPorts/SDL/releases/download/v2.0.14-update1-amigaos4/SDL2.lha" -o /tmp/SDL2.lha; \
    lha -xfq2 SDL2.lha; \
    mv ./SDL2/SDK/local/newlib /opt/sdk/SDL2; \
    rm -rf /tmp/*;

# TODO: Install GL4ES SDK
# RUN curl -fsSL "https://github.com/kas1e/GL4ES-SDK/releases/download/1.1/gl4es_sdk-1.1.lha" -o /tmp/gl4es_sdk-1.1.lha; \
#     cd /tmp; \
#     lha -xfq2 gl4es_sdk-1.1.lha; \
#     mv SDK/local/common /opt/sdk/GL4ES;

# ENV GL4ES_INC="/opt/sdk/GL4ES/include"

# TODO: Install OO Library
# RUN curl -fsSL "http://os4depot.net/share/development/library/oo.lha" -o /tmp/oo.lha; \
#     lha -xfq2 oo.lha; \
#     mv ./SDK/Local /opt/sdk/libcurl; \
#     rm -rf /tmp/*;


# TODO: Install libCurl
# RUN curl -fsSL "http://os4depot.net/share/development/library/misc/libcurl.lha" -o /tmp/libcurl.lha; \
#     cd /tmp; \
#     lha -xfq2 libcurl.lha; \
#     mv ./SDK/Local /opt/sdk/libcurl; \
#     rm -rf /tmp/*;

# ENV LIB_CURL_INC="/opt/sdk/libcurl/common/include"
# ENV LIB_CURL_NLIB="/opt/sdk/libcurl/newlib/lib"
# ENV LIB_CURL_CLIB="/opt/sdk/libcurl/clib2/lib"

# TODO: Install latest MiniGL

