#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libsdl3_image${CCEND}";
	curl -fsSL "https://os4depot.net/share/development/library/graphics/libsdl3_image.lha" -o /tmp/libsdl3_image.lha && \
		lha -xfq2 libsdl3_image.lha && \
		cp -r ./SDL3_image-3.2.4/SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;