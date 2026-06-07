#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install lz4${CCEND}";
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/lz4/lz4-1.10.0.lha" -o /tmp/lz4.lha && \
		lha -xfq2 lz4.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;