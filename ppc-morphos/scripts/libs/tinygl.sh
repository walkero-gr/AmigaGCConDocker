#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install TinyGL SDK${CCEND}";
	curl -fsSL "https://www.morphos-storage.net/dl.php?id=2227357" -o /tmp/tinygl.lha && \
		lha -xfq2 tinygl.lha && \
		cp -r ./TinyGL-Update-2024-09-29/SDK/GG/* /gg/ && \
		rm -rf /tmp/*;