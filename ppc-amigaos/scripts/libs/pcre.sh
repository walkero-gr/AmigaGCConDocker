#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install pcre${CCEND}";
	if [ -f /opt/amigalabs-libs-ports/pcre/pcre-8.45.lha ]; then
	  echo -e "${CCGREEN}${CCBOLD}pcre-8.45.lha found locally. Skipping download. ${CCEND}"
	  cp /opt/amigalabs-libs-ports/pcre/pcre-8.45.lha /tmp/pcre.lha
	else
	  echo -e "${CCYELLOW}${CCBOLD}pcre-8.45.lha not found locally. Downloading. ${CCEND}"
	  curl --retry 10 --retry-delay 10 --retry-all-errors -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/pcre/pcre-8.45.lha" -o /tmp/pcre.lha
	fi
		lha -xfq2 pcre.lha && \
		cp -r ./SDK/local/clib2/* ${SDK_PATH}/local/clib2/ && \
		cp -r ./SDK/local/newlib/* ${SDK_PATH}/local/newlib/ && \
		cp -r ./SDK/local/Documentation/* ${SDK_PATH}/local/Documentation/ && \
		rm -rf /tmp/*;
