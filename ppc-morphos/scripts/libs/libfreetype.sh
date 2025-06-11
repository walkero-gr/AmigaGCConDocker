#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libfreetype ${CCEND}";
	curl -fsSL "https://www.morphos-storage.net/dl.php?id=2299476" -o libfreetype.lha && \
		lha -xfq2 libfreetype.lha && \
		mkdir -p /gg/usr/local/lib && \
		cp -r ./freetype-2.13.3/builds/amiga/libfreetype.a /gg/usr/local/lib/libfreetype.a && \
		cp -r ./freetype-2.13.3/include /gg/usr/local/ && \
		rm -rf /tmp/*;