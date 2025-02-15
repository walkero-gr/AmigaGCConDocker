#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libzip${CCEND}";
	curl -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/libzip/libzip-1.11.2.lha" -o /tmp/libzip.lha && \
		lha -xfq2 libzip.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;