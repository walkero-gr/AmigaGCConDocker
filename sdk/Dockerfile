
FROM walkero/lha-on-docker as lha-image

# The ubuntu:latest tag points to the "latest LTS", since that's the version recommended for general use.
FROM ubuntu:latest

LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"

ARG DEBIAN_FRONTEND=noninteractive

COPY --from=lha-image /usr/bin/lha /usr/bin/lha

RUN apt-get update && apt-get -y --no-install-recommends install \
    ca-certificates \
    curl; \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

ENV APPC="/opt/ppc-amigaos" \
    OS4_SDK_PATH="/opt/sdk/ppc-amigaos" \
    OS4_SDK_LOCAL="/opt/sdk/ppc-amigaos/Local"

RUN mkdir -p ${OS4_SDK_PATH};

WORKDIR /tmp

# Install MUI 5.0 SDK
RUN curl -fsSL "https://github.com/amiga-mui/muidev/releases/download/MUI-5.0-20210831/MUI-5.0-20210831-os4.lha" -o /tmp/MUI-5.0.lha; \
    curl -fsSL "https://github.com/amiga-mui/muidev/releases/download/MUI-5.0-20210831/MUI-5.0-20210831-os4-contrib.lha" -o /tmp/MUI-5.0-contrib.lha; \
    lha -xfq2 MUI-5.0.lha; \
    lha -xfq2 MUI-5.0-contrib.lha; \
    mv ./SDK/MUI /opt/sdk/MUI_5.0; \
    rm -rf /tmp/*;

# Install AmigaOS 4 SDK
RUN curl -fskSL "https://www.hyperion-entertainment.com/index.php?option=com_registration&amp;view=download&amp;format=raw&amp;file=125&amp;Itemid=125" -o /tmp/AmigaOS4-SDK.lha && \
    lha -xfq2 AmigaOS4-SDK.lha && \
    lha -xfq2w=${OS4_SDK_PATH} SDK_Install/clib2*.lha && \
    lha -xfq2w=${OS4_SDK_PATH} SDK_Install/newlib*.lha && \
    lha -xfq2w=${OS4_SDK_PATH} SDK_Install/base.lha && \
    lha -xfq2w=${OS4_SDK_PATH} SDK_Install/pthreads*.lha && \
    lha -xfq2w=${OS4_SDK_PATH} SDK_Install/SDI-*.lha && \
    lha -xfq2w=${OS4_SDK_PATH} SDK_Install/cairo-*.lha && \
    lha -xfq2w=${OS4_SDK_PATH} SDK_Install/expat-*.lha; \
    mv ${OS4_SDK_PATH}/Include/ ${OS4_SDK_PATH}/include/ && \
    cp -r ${OS4_SDK_PATH}/Local/* ${OS4_SDK_PATH}/local/ && \
    rm -rf ${OS4_SDK_PATH}/Local && \
    rm -rf  ${OS4_SDK_PATH}/C ${OS4_SDK_PATH}/Data ${OS4_SDK_PATH}/S \
            ${OS4_SDK_PATH}/AmigaOS\ 4.1\ SDK.pdf.info \
            ${OS4_SDK_PATH}/Documentation.info; \
    rm -rf /tmp/*;

# Install SDL SDK
RUN curl -fsSL "https://github.com/AmigaPorts/SDL/releases/download/v1.2.16-rc2-amigaos4/SDL.lha" -o /tmp/SDL.lha && \
    lha -xfq2 SDL.lha && \
    cp -r ./SDL/SDK/local/* ${OS4_SDK_PATH}/local/ && \
    mv ./SDL/docs ${OS4_SDK_PATH}/local/Documentation/SDL && \
    rm -rf /tmp/*;

# Install SDL 2 SDK
RUN curl -fsSL "https://github.com/AmigaPorts/SDL-2.0/releases/download/v2.0.20-amigaos4/SDL2.lha" -o /tmp/SDL2.lha && \
    lha -xfq2 SDL2.lha && \
    cp -r ./SDL2/SDK/local/* ${OS4_SDK_PATH}/local/ && \
    mkdir ${OS4_SDK_PATH}/local/Documentation/SDL2 && \
    mv ./SDL2/LICENSE.txt ${OS4_SDK_PATH}/local/Documentation/SDL2/ && \
    mv ./SDL2/README-SDL.txt ${OS4_SDK_PATH}/local/Documentation/SDL2/ && \
    mv ./SDL2/README-amigaos4.md ${OS4_SDK_PATH}/local/Documentation/SDL2/ && \
    mv ./SDL2/WhatsNew.txt ${OS4_SDK_PATH}/local/Documentation/SDL2/ && \
    rm -rf /tmp/*;

# Install GL4ES SDK
RUN curl -fsSL "https://github.com/kas1e/GL4ES-SDK/releases/download/1.2/gl4es_sdk-1.2.lha" -o /tmp/gl4es_sdk.lha && \
    lha -xfq2 gl4es_sdk.lha && \
    cp -r ./SDK/local/newlib/* ${OS4_SDK_PATH}/local/newlib/ && \
    mv ./SDK/local/common/include/GL ${OS4_SDK_PATH}/local/common/include/GL4ES && \
    mv ./SDK/Documentation/GL4ES ${OS4_SDK_PATH}/local/Documentation/ && \
    mv ./SDK/Examples/GL4ES ${OS4_SDK_PATH}/Examples && \
    rm -rf /tmp/*;

# Install libCurl
RUN curl -fsSL "http://os4depot.net/share/development/library/misc/libcurl.lha" -o /tmp/libcurl.lha && \
    lha -xfq2 libcurl.lha && \
    cp -r ./SDK/local/* ${OS4_SDK_PATH}/local/ && \
    mv ./Docs ${OS4_SDK_PATH}/local/Documentation/libcurl && \
    rm -rf /tmp/*;

# Install jansson library
RUN curl -fsSL "http://amiga-projects.net/jansson_library_2.12.1_sdk.lha" -o /tmp/jansson.lha && \
    lha -xfq2 jansson.lha && \
    cp -r ./local/* ${OS4_SDK_PATH}/local/ && \
    rm -rf /tmp/*;

# Install libopenssl
RUN curl -fsSL "http://os4depot.net/share/development/library/misc/libopenssl.lha" -o /tmp/libopenssl.lha && \
    lha -xfq2 libopenssl.lha && \
    cp -r ./libOpenSSL/SDK/local/* ${OS4_SDK_PATH}/local/ && \
    rm -rf /tmp/*;

# Install sqlite3
RUN curl -fsSL "http://aminet.net/biz/dbase/sqlite-3.34.0-amiga.lha" -o /tmp/sqlite.lha && \
    lha -xfq2 sqlite.lha && \
    cp -r ./sqlite-3.34.0-amiga/build-ppc-amigaos/include/* ${OS4_SDK_PATH}/local/common/include/ && \
    cp -r ./sqlite-3.34.0-amiga/build-ppc-amigaos/lib/* ${OS4_SDK_PATH}/local/newlib/lib/ && \
    mkdir ${OS4_SDK_PATH}/local/Documentation/sqlite3 && \
    mv ./sqlite-3.34.0-amiga/LICENSE.md ${OS4_SDK_PATH}/local/Documentation/sqlite3/ && \
    mv ./sqlite-3.34.0-amiga/README.amiga ${OS4_SDK_PATH}/local/Documentation/sqlite3/ && \
    mv ./sqlite-3.34.0-amiga/README.md ${OS4_SDK_PATH}/local/Documentation/sqlite3/ && \
    mv ./sqlite-3.34.0-amiga/VERSION ${OS4_SDK_PATH}/local/Documentation/sqlite3/ && \
    rm -rf /tmp/*;

# Install latest MiniGL
RUN curl -fsSL "http://os4depot.net/share/driver/graphics/minigl.lha" -o /tmp/minigl.lha && \
    lha -xfq2 minigl.lha && \
    cp -r ./MiniGL/SDK/local/* ${OS4_SDK_PATH}/local/ && \
    mkdir ${OS4_SDK_PATH}/local/Documentation/minigl && \
    mv ./MiniGL/License.txt ${OS4_SDK_PATH}/local/Documentation/minigl/ && \
    mv ./MiniGL/README ${OS4_SDK_PATH}/local/Documentation/minigl/ && \
    mv ./MiniGL/demos ${OS4_SDK_PATH}/Examples/minigl && \
    rm -rf /tmp/*;

# Install libz
RUN curl -fsSL "http://os4depot.net/share/development/library/misc/libz.lha" -o /tmp/libz.lha && \
    lha -xfq2 libz.lha && \
    cp -r ./Zlib/SDK/Local/* ${OS4_SDK_PATH}/local/ && \
    mkdir ${OS4_SDK_PATH}/local/Documentation/libz && \
    mv ./Zlib/README ${OS4_SDK_PATH}/local/Documentation/libz/ && \
    rm -rf /tmp/*;

# Install liblua
RUN curl -fsSL "http://os4depot.net/share/development/language/liblua.lha" -o /tmp/liblua.lha && \
    lha -xfq2 liblua.lha && \
    cp -r ./SDK/local/* ${OS4_SDK_PATH}/local/ && \
    rm -rf /tmp/*;

# TODO: Install AmiSSL
# Install AMISSL SDK
RUN curl -fsSL "https://github.com/jens-maus/amissl/releases/download/4.12/AmiSSL-4.12.lha" -o /tmp/AmiSSL.lha; \
    lha -xfq2 AmiSSL.lha && \
    cp -r ./AmiSSL/Developer/include/* ${OS4_SDK_PATH}/include/include_h/ && \
    cp -r ./AmiSSL/Developer/xml/* ${OS4_SDK_PATH}/include/interfaces/ && \
    cp -r ./AmiSSL/Developer/lib/AmigaOS4/clib2/* ${OS4_SDK_PATH}/local/clib2/lib/ && \
    cp -r ./AmiSSL/Developer/lib/AmigaOS4/newlib/* ${OS4_SDK_PATH}/local/newlib/lib/ && \
    rm -rf /tmp/*;

# ENV AMISSL_INC="/opt/sdk/AmiSSL/include"


# TODO: Install OO Library
# RUN curl -fsSL "http://os4depot.net/share/development/library/oo.lha" -o /tmp/oo_1.17.lha && \
#     lha -xfq2 oo_1.17.lha && \
#     mv ./OO/SDK/local/common /opt/sdk/OOLib && \
#     mv /opt/sdk/OOLib/include/OO /opt/sdk/OOLib/include/oo && \
#     rm -rf /tmp/*;

# TODO: install lrtmp and lpthread
