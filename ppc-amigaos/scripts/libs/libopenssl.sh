#!/usr/bin/bash
# 
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install libopenssl${CCEND}";
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "http://os4depot.net/share/development/library/misc/libopenssl.lha" -o /tmp/libopenssl.lha && \
		lha -xfq2 libopenssl.lha && \
		cp -r ./libOpenSSL/SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;
