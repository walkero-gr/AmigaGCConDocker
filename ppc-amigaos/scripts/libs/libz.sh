#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install libz${CCEND}";
	curl --retry 5 --retry-delay 4 --retry-all-errors -fsSL "https://os4depot.net/share/development/library/misc/libz.lha" -o /tmp/libz.lha && \
		lha -xfq2 libz.lha && \
		cp -r ./Zlib/SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;
