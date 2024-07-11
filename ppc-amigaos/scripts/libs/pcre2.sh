#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install pcre2${CCEND}";
	curl -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/pcre2/pcre2-10.42.lha" -o /tmp/pcre2.lha && \
		lha -xfq2 pcre2.lha && \
		cp -r ./SDK/local/clib2/* ${SDK_PATH}/local/clib2/ && \
		cp -r ./SDK/local/newlib/* ${SDK_PATH}/local/newlib/ && \
		cp -r ./SDK/local/Documentation/* ${SDK_PATH}/local/Documentation/ && \
		rm -rf /tmp/*;