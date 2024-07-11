#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install pixman ${CCEND}";
	curl -fsSL "https://github.com/salass00/pixman_lib/releases/download/V53.5/pixman_lib-53.5.lha" -o pixman.lha && \
		lha -xfq2 pixman.lha && \
		cp -r ./pixman_lib-53.5/SDK/local/* ${SDK_PATH}/local/ && \
		rm -rf /tmp/*;