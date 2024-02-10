#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libsdl2_mixer${CCEND}";
	curl -fsSL "http://os4depot.net/share/development/library/audio/libsdl2_mixer.lha" -o /tmp/libsdl2_mixer.lha && \
		lha -xfq2 libsdl2_mixer.lha && \
		cp -r ./SDL2_mixer-2.0.1/SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;