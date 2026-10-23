#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install libwebp${CCEND}";
	curl --retry 5 --retry-delay 4 --retry-all-errors -fsSL "https://os4depot.net/share/development/library/graphics/libwebp.lha" -o /tmp/libwebp.lha && \
		lha -xfq2 libwebp.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;
