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

ENV SDK_PATH="/opt/sdk" \
    SDK_LOCAL="/opt/sdk/68k-amigaos/Local"

RUN mkdir -p ${SDK_PATH};

WORKDIR /tmp

# Install NDK 3.9
# RUN curl -fsSL "http://www.haage-partner.de/download/AmigaOS/NDK39.lha" -o /tmp/NDK39.lha || exit $?; \
#     lha -xfq2 NDK39.lha; \
#     mv ./NDK_3.9 ${SDK_PATH}/; \
#     rm -rf /tmp/*;
# ENV NDK_INC="${SDK_PATH}/NDK_3.9/Include/include_h"
# ENV NDK_LIB="${SDK_PATH}/NDK_3.9/Include/linker_libs"

# Install NDK32
# RUN curl -fsSL "http://aminet.net/dev/misc/NDK3.2.lha" -o /tmp/ndk32.lha || exit $?; \
#     lha -xfq2w=NDK3.2 ndk32.lha; \
#     mv ./NDK3.2 ${SDK_PATH}/; \
#     rm -rf /tmp/*;
# ENV NDK32_INC="${SDK_PATH}/NDK3.2/Include_H"
# ENV NDK32_LIB="${SDK_PATH}/NDK3.2/lib"

# Install MUI 3.8 dev
# RUN curl -fsSL "https://github.com/amiga-mui/muidev/releases/download/3.8/mui38dev.lha" -o /tmp/mui38dev.lha || exit $?; \
#     lha -xfq2 mui38dev.lha; \
#     mv ./MUI/Developer ${SDK_PATH}/MUI_3.8; \
#     mkdir -p ${SDK_PATH}/MUI_3.8/C/Include/mui; \
#     rm -rf /tmp/*;
# ENV MUI38_INC="${SDK_PATH}/MUI_3.8/C/Include"

# Install MUI 5.0 dev
# RUN curl -fsSL "https://github.com/amiga-mui/muidev/releases/download/MUI-5.0-20210831/MUI-5.0-20210831-os3.lha" -o /tmp/MUI-5.0.lha || exit $?; \
#     curl -fsSL "https://github.com/amiga-mui/muidev/releases/download/MUI-5.0-20210831/MUI-5.0-20210831-os3-contrib.lha" -o /tmp/MUI-5.0-contrib.lha || exit $?; \
#     lha -xfq2 MUI-5.0.lha; \
#     lha -xfq2 MUI-5.0-contrib.lha; \
#     mv ./SDK/MUI ${SDK_PATH}/MUI_5.0; \
#     rm -rf /tmp/*;
# ENV MUI50_INC="${SDK_PATH}/MUI_5.0/C/include"


# Install MCC_GuiGfx
# RUN curl -fsSL "http://aminet.net/dev/mui/MCC_Guigfx.lha" -o /tmp/MCC_Guigfx.lha || exit $?; \
#     lha -xfq2 MCC_Guigfx.lha; \
#     cp ./MCC_Guigfx/Developer/C/Include/MUI/* ${SDK_PATH}/MUI_3.8/C/Include/mui; \
#     rm -rf /tmp/*;

# Install MCC_TextEditor
# RUN curl -fsSL "http://aminet.net/dev/mui/MCC_TextEditor-15.56.lha" -o /tmp/MCC_TextEditor.lha || exit $?; \
#     lha -xfq2 MCC_TextEditor.lha; \
#     cp ./MCC_TextEditor/Developer/C/include/mui/* ${SDK_PATH}/MUI_3.8/C/Include/mui; \
#     rm -rf /tmp/*;

# Install SQLite
RUN curl -fsSL --retry 5 "http://aminet.net/biz/dbase/sqlite-3.34.0-amiga.lha" -o /tmp/sqlite.lha || exit $?; \
    lha -xfq2 sqlite.lha; \
    mkdir -p ${SDK_PATH}/sqlite/; \
    mv ./sqlite-3.34.0-amiga/build-m68k-amigaos/include/ ${SDK_PATH}/sqlite/; \
    mv ./sqlite-3.34.0-amiga/build-m68k-amigaos/lib/ ${SDK_PATH}/sqlite/; \
    rm -rf /tmp/*;
ENV SQLITE_INC="${SDK_PATH}/sqlite/include"

# TODO: Install AmiSSL
# Install AMISSL SDK
# RUN curl -fsSL "https://github.com/jens-maus/amissl/releases/download/4.12/AmiSSL-4.12.lha" -o /tmp/AmiSSL.lha; \
#     lha -xfq2 AmiSSL.lha && \
#     cp -r ./AmiSSL/Developer/include/* ${SDK_PATH}/include/include_h/ && \
#     cp -r ./AmiSSL/Developer/xml/* ${SDK_PATH}/include/interfaces/ && \
#     cp -r ./AmiSSL/Developer/lib/AmigaOS4/clib2/* ${SDK_PATH}/local/clib2/lib/ && \
#     cp -r ./AmiSSL/Developer/lib/AmigaOS4/newlib/* ${SDK_PATH}/local/newlib/lib/ && \
#     rm -rf /tmp/*;

