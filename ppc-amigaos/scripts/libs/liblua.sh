#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install liblua 5.5 ${CCEND}";
    curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "https://os4depot.net/share/development/language/liblua.lha" -o /tmp/liblua.lha && \
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
    curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "https://github.com/AmigaLabs/libs-ports/raw/refs/heads/main/lua5.4/lua-5.4.8.lha" -o /tmp/liblua54.lha && \
        lha -xfq2 liblua54.lha && \
        rm -rf SDK/local/newlib/bin/ && \
        rm -rf SDK/local/clib2/bin/ && \
        rm -rf SDK/local/clib4/bin/ && \
        cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
        rm -rf /tmp/*;

echo -e "${CCPINK}${CCBOLD}\n---> Install liblua 5.1 ${CCEND}";
    curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "https://github.com/AmigaLabs/libs-ports/raw/refs/heads/main/lua5.1/lua-5.1.5.lha" -o /tmp/liblua51.lha && \
        lha -xfq2 liblua51.lha && \
        rm -rf SDK/local/newlib/bin/ && \
        rm -rf SDK/local/clib2/bin/ && \
        rm -rf SDK/local/clib4/bin/ && \
        cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
        rm -rf /tmp/*;
