#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install SDL3 SDK${CCEND}";
	curl -fsSL "https://github.com/AmigaPorts/SDL/releases/download/v3.2.14-amigaos4/SDL3.lha" -o /tmp/SDL3.lha && \
		lha -xfq2 SDL3.lha && \
		cp -r ./SDL3/SDK/local/* ${SDK_PATH}/local/ && \
		mkdir -p ${SDK_PATH}/local/Documentation/SDL3 && \
		mv ./SDL3/LICENSE.txt ${SDK_PATH}/local/Documentation/SDL3/ && \
		mv ./SDL3/README.md ${SDK_PATH}/local/Documentation/SDL3/ && \
		mv ./SDL3/README-amigaos4.md ${SDK_PATH}/local/Documentation/SDL3/ && \
		mv ./SDL3/WhatsNew.txt ${SDK_PATH}/local/Documentation/SDL3/ && \
		rm -rf /tmp/*;