#!/usr/bin/bash
# 
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install libsdl2_gfx${CCEND}";
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "https://os4depot.net/share/development/library/graphics/libsdl2_gfx.lha" -o /tmp/libsdl2_gfx.lha && \
		lha -xfq2 libsdl2_gfx.lha && \
		cp -r ./SDL2_gfx-1.0.4/SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;
