#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install Cairo ${CCEND}";
	curl -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/libcairo/libcairo-1.14.10.lha" -o /tmp/libcairo.lha && \
		lha -xfq2 libcairo.lha && \
		\cp -R ./SDK/* ${SDK_PATH}/ && \
		rm -rf /tmp/*;
