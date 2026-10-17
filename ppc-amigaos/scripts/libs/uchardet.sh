#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install uchardet ${CCEND}";
	if [ -f /opt/amigalabs-libs-ports/uchardet/uchardet-v0.0.8.lha ]; then
	  echo -e "${CCGREEN}${CCBOLD}uchardet-v0.0.8.lha found in /opt/amigalabs-libs-ports. Skipping download. ${CCEND}"
	  cp /opt/amigalabs-libs-ports/uchardet/uchardet-v0.0.8.lha /tmp/uchardet.lha
	else
	  echo -e "${CCYELLOW}${CCBOLD}uchardet-v0.0.8.lha not found locally. Downloading. ${CCEND}"
	  curl --retry 10 --retry-delay 10 --retry-all-errors -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/uchardet/uchardet-v0.0.8.lha" -o /tmp/uchardet.lha
	fi
		lha -xfq2 uchardet.lha && \
		cp -r ./uchardet-v0.0.8/SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;
