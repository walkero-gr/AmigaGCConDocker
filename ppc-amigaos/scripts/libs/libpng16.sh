#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libpng16 ${CCEND}";
	curl --retry 5 --retry-delay 2 --retry-connrefused -fsSL "https://os4depot.net/share/development/library/graphics/libpng.lha" -o /tmp/libpng.lha && \
		lha -xfq2 libpng.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;