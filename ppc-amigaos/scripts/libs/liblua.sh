#!/usr/bin/bash
# 
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install liblua 5.4 ${CCEND}";
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "https://os4depot.net/share/development/language/liblua.lha" -o /tmp/liblua.lha && \
		lha -xfq2 liblua.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;	
