#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install libgmp${CCEND}";
  if [ -f /opt/amigalabs-libs-ports/gmp/gmp-6.3.0.lha ]; then
    echo -e "${CCGREEN}${CCBOLD}gmp-6.3.0.lha found in /opt/amigalabs-libs-ports. Skipping download. ${CCEND}"
    cp /opt/amigalabs-libs-ports/gmp/gmp-6.3.0.lha /tmp/gmp.lha
  else
    echo -e "${CCYELLOW}${CCBOLD}gmp-6.3.0.lha not found locally. Downloading. ${CCEND}"
    curl --retry 10 --retry-delay 10 --retry-all-errors -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/gmp/gmp-6.3.0.lha" -o /tmp/gmp.lha
  fi
    lha -xfq2 gmp.lha && \
    cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
    rm -rf /tmp/*;
