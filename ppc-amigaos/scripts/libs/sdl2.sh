#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install SDL2 SDK${CCEND}";
	curl -fsSL "https://github.com/AmigaPorts/SDL/releases/download/v2.30.4-amigaos4/SDL2.lha" -o /tmp/SDL2.lha && \
		lha -xfq2 SDL2.lha && \
		cp -r ./SDL2/SDK/local/* ${SDK_PATH}/local/ && \
		mkdir ${SDK_PATH}/local/Documentation/SDL2 && \
		mv ./SDL2/LICENSE.txt ${SDK_PATH}/local/Documentation/SDL2/ && \
		mv ./SDL2/README-SDL.txt ${SDK_PATH}/local/Documentation/SDL2/ && \
		mv ./SDL2/README-amigaos4.md ${SDK_PATH}/local/Documentation/SDL2/ && \
		mv ./SDL2/WhatsNew.txt ${SDK_PATH}/local/Documentation/SDL2/ && \
		rm -rf /tmp/*;