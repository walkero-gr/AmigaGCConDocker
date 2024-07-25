#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libxml2${CCEND}";
	curl -fsSL "http://os4depot.net/share/library/xml/libxml2.lha" -o /tmp/libxml2.lha && \
		lha -xfq2 libxml2.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;