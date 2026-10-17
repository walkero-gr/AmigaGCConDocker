#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install lz4${CCEND}";
	if [ -f /opt/amigalabs-libs-ports/lz4/lz4-1.10.0.lha ]; then
	  echo -e "${CCGREEN}${CCBOLD}lz4-1.10.0.lha found in /opt/amigalabs-libs-ports. Skipping download. ${CCEND}"
	  cp /opt/amigalabs-libs-ports/lz4/lz4-1.10.0.lha /tmp/lz4.lha
	else
	  echo -e "${CCYELLOW}${CCBOLD}lz4-1.10.0.lha not found locally. Downloading. ${CCEND}"
	  curl --retry 10 --retry-delay 10 --retry-all-errors -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/lz4/lz4-1.10.0.lha" -o /tmp/lz4.lha
	fi
		lha -xfq2 lz4.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;
