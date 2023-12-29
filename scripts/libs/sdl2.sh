#!/usr/bin/bash
# 

echo "---> Install SDL2 SDK";
	curl -fsSL "https://github.com/AmigaPorts/SDL-2.0/releases/download/v2.28.0-amigaos4/SDL2.lha" -o /tmp/SDL2.lha && \
		lha -xfq2 SDL2.lha && \
		cp -r ./SDL2/SDK/local/* ${SDK_PATH}/local/ && \
		mkdir ${SDK_PATH}/local/Documentation/SDL2 && \
		mv ./SDL2/LICENSE.txt ${SDK_PATH}/local/Documentation/SDL2/ && \
		mv ./SDL2/README-SDL.txt ${SDK_PATH}/local/Documentation/SDL2/ && \
		mv ./SDL2/README-amigaos4.md ${SDK_PATH}/local/Documentation/SDL2/ && \
		mv ./SDL2/WhatsNew.txt ${SDK_PATH}/local/Documentation/SDL2/ && \
		rm -rf /tmp/*;