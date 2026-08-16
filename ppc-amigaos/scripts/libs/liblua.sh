#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install liblua 5.5 ${CCEND}";
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "https://os4depot.net/share/development/language/liblua.lha" -o /tmp/liblua.lha && \
		lha -xfq2 liblua.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;

echo -e "${CCPINK}${CCBOLD}\n---> Install liblua 5.4 ${CCEND}";
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "https://github.com/AmigaLabs/libs-ports/raw/refs/heads/main/lua5.4/lua-5.4.8.lha" -o /tmp/liblua54.lha && \
		lha -xfq2 liblua54.lha && \
		rm -rf SDK/local/newlib/bin/ && \
		rm -rf SDK/local/clib2/bin/ && \
		rm -rf SDK/local/clib4/bin/ && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;
