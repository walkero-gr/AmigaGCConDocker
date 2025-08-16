#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libsdl2_image${CCEND}";
	curl -fsSL "https://os4depot.net/share/development/library/graphics/libsdl2_image.lha" -o /tmp/libsdl2_image.lha && \
		lha -xfq2 libsdl2_image.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;