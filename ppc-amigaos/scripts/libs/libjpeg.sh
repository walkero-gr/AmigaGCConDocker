#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libjpeg${CCEND}";
	curl -fsSL "http://os4depot.net/share/development/library/graphics/libjpeg.lha" -o /tmp/libjpeg.lha && \
		lha -xfq2 libjpeg.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;