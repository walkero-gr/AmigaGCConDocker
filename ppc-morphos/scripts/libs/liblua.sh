#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install liblua 5.4 ${CCEND}";
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "https://github.com/walkero-gr/morphos-libs/raw/refs/heads/main/lua5.4/lua-5.4.9.lha" -o /tmp/lua54.lha && \
		lha -xfq2 lua54.lha && \
		cp -r ./lua-5.4.9/SDK/* /gg/ && \
		rm -rf /tmp/*;
