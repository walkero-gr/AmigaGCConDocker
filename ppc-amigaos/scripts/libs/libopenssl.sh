#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libopenssl${CCEND}";
	curl -fsSL "http://os4depot.net/share/development/library/misc/libopenssl.lha" -o /tmp/libopenssl.lha && \
		lha -xfq2 libopenssl.lha && \
		cp -r ./libOpenSSL/SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;