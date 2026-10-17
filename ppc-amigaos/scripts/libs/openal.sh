#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install openal ${CCEND}";
  if [ -f /opt/amigalabs-libs-ports/libopenal/libopenal-1.18.2.lha ]; then
    echo -e "${CCGREEN}${CCBOLD}libopenal-1.18.2.lha found locally. Skipping download. ${CCEND}"
    cp /opt/amigalabs-libs-ports/libopenal/libopenal-1.18.2.lha /tmp/openal.lha
  else
    echo -e "${CCYELLOW}${CCBOLD}libopenal-1.18.2.lha not found locally. Downloading. ${CCEND}"
    curl --retry 10 --retry-delay 10 --retry-all-errors -fsSL "https://github.com/AmigaLabs/libs-ports/raw/refs/heads/main/libopenal/libopenal-1.18.2.lha" -o /tmp/openal.lha
  fi
    lha -xfq2 /tmp/openal.lha && \
    cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
    rm -rf /tmp/*;
