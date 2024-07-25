#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libsdl_ttf${CCEND}";
	curl -fsSL "http://os4depot.net/share/development/library/graphics/libsdl_ttf.lha" -o /tmp/libsdl_ttf.lha && \
		lha -xfq2 libsdl_ttf.lha && \
		cp -r ./SDL_ttf-2.0.11/SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;