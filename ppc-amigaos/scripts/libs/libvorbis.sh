#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libvorbis${CCEND}";
	curl -fsSL "http://os4depot.net/share/development/library/audio/libvorbis.lha" -o /tmp/libvorbis.lha && \
		lha -xfq2 libvorbis.lha && \
		cp -r ./libvorbis-1.3.7/SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;