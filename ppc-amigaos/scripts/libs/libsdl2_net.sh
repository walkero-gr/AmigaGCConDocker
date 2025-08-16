#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libsdl2_net ${CCEND}";
	curl -fsSL "https://os4depot.net/share/development/library/misc/libsdl2_net.lha" -o /tmp/libsdl2_net.lha && \
		lha -xfq2 libsdl2_net.lha && \
		cp -r ./SDL2_net-2.2.0/SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;