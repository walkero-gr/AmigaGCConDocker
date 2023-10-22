#!/usr/bin/bash
# 

echo "---> Install SDL SDK";
	curl -fsSL "https://github.com/AmigaPorts/SDL/releases/download/v1.2.16-rc2-amigaos4/SDL.lha" -o /tmp/SDL.lha && \
		lha -xfq2 SDL.lha && \
		cp -r ./SDL/SDK/local/* ${OS4_SDK_PATH}/local/ && \
		mv ./SDL/docs ${OS4_SDK_PATH}/local/Documentation/SDL && \
		rm -rf /tmp/*;