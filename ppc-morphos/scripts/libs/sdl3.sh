#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install SDL3 SDK ${CCEND}";
	curl -fsSL "https://www.morphos-storage.net/dl.php?id=2349848" -o /tmp/SDL3.lha && \
		lha -xfq2 SDL3.lha && \
		cp -r ./SDL_3.2.8/SDK/* /gg/ && \
		rm -rf /tmp/*;