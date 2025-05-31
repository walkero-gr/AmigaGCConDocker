#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libsdl3_gfx${CCEND}";
	curl -fsSL "https://os4depot.net/share/development/library/graphics/libsdl3_gfx.lha" -o /tmp/libsdl3_gfx.lha && \
		lha -xfq2 libsdl3_gfx.lha && \
		cp -r ./SDL3_gfx-1.0.1/SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;