#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install pcre2${CCEND}";
	if [ -f /opt/amigalabs-libs-ports/pcre2/pcre2-10.45.lha ]; then
	  echo -e "${CCGREEN}${CCBOLD}pcre2-10.45.lha found locally. Skipping download. ${CCEND}"
	  cp /opt/amigalabs-libs-ports/pcre2/pcre2-10.45.lha /tmp/pcre2.lha
	else
	  echo -e "${CCYELLOW}${CCBOLD}pcre2-10.45.lha not found locally. Downloading. ${CCEND}"
	  curl --retry 10 --retry-delay 10 --retry-all-errors -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/pcre2/pcre2-10.45.lha" -o /tmp/pcre2.lha
	fi
		lha -xfq2 pcre2.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;
