#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install SDL2 SDK${CCEND}";
	curl -fsSL "https://www.morphos-storage.net/dl.php?id=2227083" -o /tmp/SDL2.lha && \
		lha -xfq2 SDL2.lha && \
		cp -r ./SDL_2.30.7_Libraries/SDK/* /gg/ && \
		rm -rf /tmp/*;