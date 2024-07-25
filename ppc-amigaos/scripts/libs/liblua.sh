#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install liblua 5.4${CCEND}";
	curl -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/lua5.4/lua-5.4.6.lha" -o /tmp/liblua.lha && \
		lha -xfq2 liblua.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;