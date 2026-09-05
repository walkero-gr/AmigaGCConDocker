#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install libfreetype ${CCEND}";
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "https://github.com/walkero-gr/morphos-libs/raw/refs/heads/main/freetype/freetype-2.14.3.lha" -o /tmp/freetype.lha && \
		lha -xfq2 freetype.lha && \
		cp -r ./freetype-2.14.3/SDK/* /gg/ && \
		rm -rf /tmp/*;
