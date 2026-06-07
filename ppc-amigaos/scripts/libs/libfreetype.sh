#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libfreetype ${CCEND}";
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "http://os4depot.net/share/development/library/graphics/libfreetype.lha" -o libfreetype.lha && \
		lha -xfq2 libfreetype.lha && \
		cp -r ./Freetype2/SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;