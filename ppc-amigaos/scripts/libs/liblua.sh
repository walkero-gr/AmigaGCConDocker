#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install liblua 5.5 ${CCEND}";
    curl --retry 10 --retry-delay 10 --retry-all-errors -fsSL "https://os4depot.net/share/development/language/liblua.lha" -o /tmp/liblua.lha && \
        lha -xfq2 liblua.lha && \
        mkdir -p ./SDK/local/common/include/lua55 && \
        mv ./SDK/local/common/include/*.h* ./SDK/local/common/include/lua55/ && \
        mv ./SDK/local/newlib/lib/liblua.a ./SDK/local/newlib/lib/liblua55.a && \
        ln -r -s ./SDK/local/newlib/lib/liblua55.a ./SDK/local/newlib/lib/liblua.a && \
        mv ./SDK/local/clib2/lib/liblua.a ./SDK/local/clib2/lib/liblua55.a && \
        ln -r -s ./SDK/local/clib2/lib/liblua55.a ./SDK/local/clib2/lib/liblua.a && \
        mv ./SDK/local/clib4/lib/liblua.a ./SDK/local/clib4/lib/liblua55.a && \
        ln -r -s ./SDK/local/clib4/lib/liblua55.a ./SDK/local/clib4/lib/liblua.a && \
        cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
        rm -rf /tmp/*;

echo -e "${CCPINK}${CCBOLD}\n---> Install liblua 5.4 ${CCEND}";
    if [ -f /opt/amigalabs-libs-ports/lua5.4/lua-5.4.8.lha ]; then
      echo -e "${CCGREEN}${CCBOLD}lua-5.4.8.lha found locally. Skipping download. ${CCEND}"
      cp /opt/amigalabs-libs-ports/lua5.4/lua-5.4.8.lha /tmp/liblua54.lha
    else
      echo -e "${CCYELLOW}${CCBOLD}lua-5.4.8.lha not found locally. Downloading. ${CCEND}"
      curl --retry 10 --retry-delay 10 --retry-all-errors -fsSL "https://github.com/AmigaLabs/libs-ports/raw/refs/heads/main/lua5.4/lua-5.4.8.lha" -o /tmp/liblua54.lha
    fi
        lha -xfq2 liblua54.lha && \
        rm -rf SDK/local/newlib/bin/ && \
        rm -rf SDK/local/clib2/bin/ && \
        rm -rf SDK/local/clib4/bin/ && \
        cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
        rm -rf /tmp/*;

echo -e "${CCPINK}${CCBOLD}\n---> Install liblua 5.1 ${CCEND}";
    if [ -f /opt/amigalabs-libs-ports/lua5.1/lua-5.1.5.lha ]; then
      echo -e "${CCGREEN}${CCBOLD}lua-5.1.5.lha found locally. Skipping download. ${CCEND}"
      cp /opt/amigalabs-libs-ports/lua5.1/lua-5.1.5.lha /tmp/liblua51.lha
    else
      echo -e "${CCYELLOW}${CCBOLD}lua-5.1.5.lha not found locally. Downloading. ${CCEND}"
      curl --retry 10 --retry-delay 10 --retry-all-errors -fsSL "https://github.com/AmigaLabs/libs-ports/raw/refs/heads/main/lua5.1/lua-5.1.5.lha" -o /tmp/liblua51.lha
    fi
        lha -xfq2 liblua51.lha && \
        rm -rf SDK/local/newlib/bin/ && \
        rm -rf SDK/local/clib2/bin/ && \
        rm -rf SDK/local/clib4/bin/ && \
        cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
        rm -rf /tmp/*;
