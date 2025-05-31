#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libsdl3_ttf${CCEND}";
	curl -fsSL "https://os4depot.net/share/development/library/graphics/libsdl3_ttf.lha" -o /tmp/libsdl3_ttf.lha && \
		lha -xfq2 libsdl3_ttf.lha && \
		cp -r ./SDL3_ttf-3.2.2/SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;