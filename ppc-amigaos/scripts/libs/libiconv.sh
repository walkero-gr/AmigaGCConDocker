#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install libiconv${CCEND}";
	curl --retry 10 --retry-delay 10 --retry-all-errors -fsSL "https://os4depot.net/share/development/library/misc/libiconv.lha" -o /tmp/libiconv.lha && \
		lha -xfq2 libiconv.lha && \
		cp -r ./libiconv-1.11/include/iconv.h \
			./libiconv-1.11/libcharset/include/libcharset.h \
			${SDK_PATH}/local/newlib/include/ && \
		cp -r ./libiconv-1.11/lib/libiconv* \
			${SDK_PATH}/local/newlib/lib/ && \
		cp -r ./libiconv-1.11/libcharset/lib/.libs/libcharset* \
			./libiconv-1.11/libcharset/lib/libcharset.la \
			${SDK_PATH}/local/newlib/lib/ && \
		rm -rf /tmp/*;
		\
	if [ -f /opt/amigalabs-libs-ports/libiconv/libiconv-1.17.lha ]; then
	  echo -e "${CCGREEN}${CCBOLD}libiconv-1.17.lha found locally. Skipping download. ${CCEND}"
	  cp /opt/amigalabs-libs-ports/libiconv/libiconv-1.17.lha /tmp/libiconv.lha
	else
	  echo -e "${CCYELLOW}${CCBOLD}libiconv-1.17.lha not found locally. Downloading. ${CCEND}"
	  curl --retry 10 --retry-delay 10 --retry-all-errors -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/libiconv/libiconv-1.17.lha" -o /tmp/libiconv.lha
	fi
		lha -xfq2 libiconv.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;
