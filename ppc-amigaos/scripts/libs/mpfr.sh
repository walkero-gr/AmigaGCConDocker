#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install mpfr${CCEND}";
  if [ -f /opt/amigalabs-libs-ports/mpfr/mpfr-4.2.1.lha ]; then
    echo -e "${CCGREEN}${CCBOLD}mpfr-4.2.1.lha found locally. Skipping download. ${CCEND}"
    cp /opt/amigalabs-libs-ports/mpfr/mpfr-4.2.1.lha /tmp/mpfr.lha
  else
    echo -e "${CCYELLOW}${CCBOLD}mpfr-4.2.1.lha not found locally. Downloading. ${CCEND}"
    curl --retry 10 --retry-delay 10 --retry-all-errors -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/mpfr/mpfr-4.2.1.lha" -o /tmp/mpfr.lha
  fi
    lha -xfq2 mpfr.lha && \
    cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
    rm -rf /tmp/*;
