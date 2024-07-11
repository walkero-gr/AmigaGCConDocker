#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libwebp${CCEND}";
	curl -fsSL "http://os4depot.net/share/development/library/graphics/libwebp.lha" -o /tmp/libwebp.lha && \
		lha -xfq2 libwebp.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;