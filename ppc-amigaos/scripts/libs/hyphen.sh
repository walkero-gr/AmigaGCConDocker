#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install hyphen library${CCEND}";
	if [ -f /opt/amigalabs-libs-ports/hyphen/hyphen-2.8.8.lha ]; then
	  echo -e "${CCGREEN}${CCBOLD}hyphen-2.8.8.lha found in /opt/amigalabs-libs-ports. Skipping download. ${CCEND}"
	  cp /opt/amigalabs-libs-ports/hyphen/hyphen-2.8.8.lha /tmp/libhyphen.lha
	else
	  echo -e "${CCYELLOW}${CCBOLD}hyphen-2.8.8.lha not found locally. Downloading. ${CCEND}"
	  curl --retry 10 --retry-delay 10 --retry-all-errors -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/hyphen/hyphen-2.8.8.lha" -o /tmp/libhyphen.lha
	fi
		lha -xfq2 libhyphen.lha && \
		\cp -R ./SDK/* ${SDK_PATH}/ && \
		rm -rf /tmp/*;
