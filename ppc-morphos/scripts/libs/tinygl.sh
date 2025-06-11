#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install TinyGL SDK${CCEND}";
	curl -fsSL "https://tinygl.molsen.co.za/TinyGL-Update-2024-09-29.lha" -o /tmp/tinygl.lha && \
		lha -xfq2 tinygl.lha && \
		cp -r ./TinyGL-Update-2024-09-29/SDK/GG/* /gg/ && \
		rm -rf /tmp/*;