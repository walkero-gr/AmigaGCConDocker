#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install libicu ${CCEND}";
  curl --retry 5 --retry-delay 4 --retry-all-errors -fsSL "https://os4depot.net/share/development/library/misc/libicu.lha" -o libicu.lha && \
    lha -xfq2 libicu.lha && \
    rm -rf ${SDK_PATH}/local/clib4/lib/icu ${SDK_PATH}/local/clib4/include/unicode && \
    cp -r ./libICU-78.3/SDK/local/* ${SDK_PATH}/local/ && \
    rm -rf /tmp/*;
