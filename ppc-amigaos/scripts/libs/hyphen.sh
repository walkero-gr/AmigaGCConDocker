#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install hyphen library${CCEND}";
	curl -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/hyphen/hyphen-2.8.8.lha" -o /tmp/libhyphen.lha && \
		lha -xfq2 libhyphen.lha && \
		\cp -R ./SDK/* ${SDK_PATH}/ && \
		rm -rf /tmp/*;