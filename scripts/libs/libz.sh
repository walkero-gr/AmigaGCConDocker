#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libz${CCEND}";
	curl -fsSL "http://os4depot.net/share/development/library/misc/libz.lha" -o /tmp/libz.lha && \
		lha -xfq2 libz.lha && \
		cp -r ./Zlib/SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;