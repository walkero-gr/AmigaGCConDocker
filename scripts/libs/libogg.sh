#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libogg${CCEND}";
	curl -fsSL "http://os4depot.net/share/development/library/audio/libogg.lha" -o /tmp/libogg.lha && \
		lha -xfq2 libogg.lha && \
		cp -r ./libogg-1.3.5/SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;