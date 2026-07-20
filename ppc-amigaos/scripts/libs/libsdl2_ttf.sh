#!/usr/bin/bash
# 
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install libsdl2_ttf${CCEND}";
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "https://os4depot.net/share/development/library/graphics/libsdl2_ttf.lha" -o /tmp/libsdl2_ttf.lha && \
		lha -xfq2 libsdl2_ttf.lha && \
		cp -r ./SDL2_ttf-2.24.0/SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;
