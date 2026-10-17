#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install Cairo ${CCEND}";
  if [ -f /opt/amigalabs-libs-ports/libcairo/libcairo-1.14.10.lha ]; then
    echo -e "${CCGREEN}${CCBOLD}libcairo.lha found locally. Skipping download. ${CCEND}"
    cp /opt/amigalabs-libs-ports/libcairo/libcairo-1.14.10.lha /tmp/libcairo.lha
  else
    echo -e "${CCYELLOW}${CCBOLD}libcairo.lha not found locally. Downloading. ${CCEND}"
    curl --retry 10 --retry-delay 10 --retry-all-errors -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/libcairo/libcairo-1.14.10.lha" -o /tmp/libcairo.lha
  fi;
    lha -xfq2 libcairo.lha && \
      \cp -R ./SDK/* ${SDK_PATH}/ && \
      rm -rf /tmp/*
