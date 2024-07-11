#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libCurl${CCEND}";
	curl -fsSL "http://os4depot.net/share/development/library/misc/libcurl.lha" -o /tmp/libcurl.lha && \
		lha -xfq2 libcurl.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		mv ./Docs ${SDK_PATH}/local/Documentation/libcurl && \
		rm -rf /tmp/*;