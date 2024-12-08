#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libfreetype ${CCEND}";
	curl -fsSL "https://www.morphos-storage.net/dl.php?id=1998677" -o libfreetype.lha && \
		lha -xfq2 libfreetype.lha && \
		cp -r ./freetype2_2.13.2/morphos/usr/local/* /gg/ && \
		rm -rf /tmp/*;