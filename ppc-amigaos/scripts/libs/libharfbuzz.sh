#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install libharfbuzz ${CCEND}";
	curl -fsSL "https://os4depot.net/share/development/library/graphics/libharfbuzz.lha" -o libharfbuzz.lha && \
		lha -xfq2 libharfbuzz.lha && \
		cp -r ./SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;