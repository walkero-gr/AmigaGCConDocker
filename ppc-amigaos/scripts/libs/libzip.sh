#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install libzip${CCEND}";
  if [ -f /opt/amigalabs-libs-ports/libzip/libzip-1.11.2.lha ]; then
    echo -e "${CCGREEN}${CCBOLD}libzip-1.11.2.lha found locally. Skipping download. ${CCEND}"
    cp /opt/amigalabs-libs-ports/libzip/libzip-1.11.2.lha /tmp/libzip.lha
  else
    echo -e "${CCYELLOW}${CCBOLD}libzip-1.11.2.lha not found locally. Downloading. ${CCEND}"
    curl --retry 10 --retry-delay 10 --retry-all-errors -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/libzip/libzip-1.11.2.lha" -o /tmp/libzip.lha
  fi
    lha -xfq2 libzip.lha && \
    cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
    rm -rf /tmp/*;
