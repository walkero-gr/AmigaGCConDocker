#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install uchardet ${CCEND}";
	curl -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/uchardet/uchardet-v0.0.8.lha" -o /tmp/uchardet.lha && \
		lha -xfq2 uchardet.lha && \
		cp -r ./uchardet-v0.0.8/SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;