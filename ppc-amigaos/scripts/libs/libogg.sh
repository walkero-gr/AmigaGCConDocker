#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install libogg${CCEND}";
	curl --retry 5 --retry-delay 4 --retry-all-errors -fsSL "https://os4depot.net/share/development/library/audio/libogg.lha" -o /tmp/libogg.lha && \
		lha -xfq2 libogg.lha && \
		cp -r ./libogg-1.3.6/SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;
